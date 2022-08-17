//
//  ImagesCollectionViewController.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 06/08/2022.
//

import UIKit
import Combine

class ImagesCollectionViewController: UICollectionViewController, ViewModelable {

	var viewModel: ImagesViewModel!

	private var subscribers = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupViews()
		setupCollectionViewLayout()
		setupCombine()
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		coordinator.animate(alongsideTransition: { [weak self] _ in
			self?.setupCollectionViewLayout()
		})
		super.viewWillTransition(to: size, with: coordinator)
	}

}

private extension ImagesCollectionViewController {
	func setupViews() {
		collectionView.register(ImageCollectionViewCell.nib, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
		collectionView.addGestureRecognizer({
			let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(gestureRecognizer:)))
			longPressGestureRecognizer.minimumPressDuration = 1
			longPressGestureRecognizer.delaysTouchesBegan = true
			return longPressGestureRecognizer
		}())
	}

	func setupCollectionViewLayout() {
		collectionView.setCollectionViewLayout({
			let layout = UICollectionViewFlowLayout()
			layout.scrollDirection = .vertical
			layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
			layout.minimumLineSpacing = 8
			layout.minimumInteritemSpacing = 8
			layout.itemSize = {
				let numberOfItems: CGFloat = 3
				let paddingSpace = ((numberOfItems - 1) * layout.minimumInteritemSpacing) + layout.sectionInset.left + layout.sectionInset.right
				let widthPerItem = (collectionView.frame.width - paddingSpace) / numberOfItems
				let height: CGFloat = widthPerItem
				return CGSize(width: widthPerItem, height: height)
			}()
			return layout
		}(), animated: true)
	}

	func setupCombine() {
		self.viewModel
			.itemDeleted
			.sink { [weak self] indexPath in self?.collectionView.deleteItems(at: [indexPath]) }
			.store(in: &self.subscribers)
	}

	@objc func onLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
		guard gestureRecognizer.state == .began, let indexPath = collectionView.indexPathForItem(at: gestureRecognizer.location(in: collectionView)) else { return }
		self.viewModel.deleteItem(at: indexPath)
	}
}

extension ImagesCollectionViewController {
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return self.viewModel.numberOfSections()
	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel.numberOfItems(in: section)
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
		cell.imageModel = self.viewModel.getImageModel(at: indexPath)
		return cell
	}
}

extension ImagesCollectionViewController {
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.viewModel.itemSelected()
	}
}
