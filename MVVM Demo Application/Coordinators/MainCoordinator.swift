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
				self?.showNumbersViewController()
			})
			.store(in: &self.subscribers)
		let startViewController = StartViewController.instantiate(with: startViewModel)
		self.navigationController.pushViewController(startViewController, animated: true)
	}
	func showNumbersViewController() {
		let numbersViewModel = NumbersViewModel()
		numbersViewModel
			.onNumberSelected
			.sink(receiveValue: { [weak self] numberModel in
				guard let startViewController = self?.navigationController.viewControllers.first as? StartViewController else { return }
				startViewController.viewModel.numberModelUpdated(numberModel)
				self?.navigationController.popToRootViewController(animated: true)
			})
			.store(in: &self.subscribers)
		let numbersViewController = NumbersTableViewController(viewModel: numbersViewModel)
		self.navigationController.pushViewController(numbersViewController, animated: true)
	}
}
