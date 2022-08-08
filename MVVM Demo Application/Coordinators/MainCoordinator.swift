//
//  MainCoordinator.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit
import Combine

class MainCoordinator: Coordinator {
	var navigationController: UINavigationController
	var children: [Coordinator]

	private var subscribers = Set<AnyCancellable>()

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.children = [Coordinator]()
	}
	func start() {
		let startViewModel = StartViewModel()
		startViewModel
			.onStartPressed
			.sink(receiveValue: { [weak self] in
				self?.showListTableViewController()
			})
			.store(in: &self.subscribers)
		startViewModel
			.onDataPassedPressed
			.sink(receiveValue: { [weak self] model in
				guard let numberModel = model as? NumberModel else { return }
				self?.showImagesViewController(numberModel: numberModel)
			})
			.store(in: &self.subscribers)
		let startViewController = StartViewController.instantiate(with: startViewModel)
		self.navigationController.pushViewController(startViewController, animated: true)
	}
	func showListTableViewController() {
		let listViewModel = ListViewModel(numbersService: MockNumbersService())
		listViewModel
			.onModelSelected
			.sink(receiveValue: { [weak self] model in
				guard let startViewController = self?.navigationController.viewControllers.first as? StartViewController else { return }
				startViewController.viewModel.modelUpdated(model)
				self?.navigationController.popToRootViewController(animated: true)
			})
			.store(in: &self.subscribers)
		let listTableViewController = ListTableViewController(viewModel: listViewModel)
		self.navigationController.pushViewController(listTableViewController, animated: true)
	}
	func showImagesViewController(numberModel: NumberModel) {
		let imagesViewModel = ImagesViewModel(numberModel: numberModel)
		let imagesViewController = ImagesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout(), viewModel: imagesViewModel)
		self.navigationController.pushViewController(imagesViewController, animated: true)
	}
}
