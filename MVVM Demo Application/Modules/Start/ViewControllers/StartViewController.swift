//
//  StartViewController.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit
import Combine

class StartViewController: UIViewController, Nibable, ViewModelable {

	var viewModel: StartViewModel!

	private var subscribers = Set<AnyCancellable>()

	@IBOutlet private var btnStart: UIButton!

	@IBOutlet private var btnDataPassed: PressAnimationButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupViews()
		setupCombine()
	}

}

private extension StartViewController {
	func setupViews() {
		self.view.addGestureRecognizer({
			let tapGestureRecognizer = UITapGestureRecognizer()
			tapGestureRecognizer.delegate = self
			tapGestureRecognizer.numberOfTapsRequired = 6
			tapGestureRecognizer.addTarget(self.viewModel!, action: #selector(StartViewModel.sixTapsPressed))
			return tapGestureRecognizer
		}())
		self.btnStart.addTarget(self.viewModel, action: #selector(StartViewModel.startPressed), for: .touchUpInside)
	}

	func setupCombine() {
		self.viewModel
			.numberModelUpdate
			.sink { [weak self] numberModel in
				self?.btnStart.setTitle("\(numberModel.number)", for: .normal)
				self?.btnDataPassed.isHidden = false
			}
			.store(in: &self.subscribers)
		
		self.viewModel
			.colorUpdate
			.sink(receiveValue: { [weak self] color in
				self?.view.backgroundColor = color
			})
			.store(in: &self.subscribers)
	}
}

extension StartViewController: UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
		return touch.view == gestureRecognizer.view
	}
}
