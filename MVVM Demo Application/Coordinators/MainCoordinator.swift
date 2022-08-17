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
			.map { ListService(listType: .numbers) }
			.sink { [weak self] listService in self?.showListTableViewController(with: listService) }
			.store(in: &self.subscribers)
		startViewModel
			.onDataPassedPressed
			.compactMap { $0 as? NumberModel }
			.sink { [weak self] numberModel in self?.showImagesViewController(with: numberModel) }
			.store(in: &self.subscribers)
		let startViewController = StartViewController.instantiate(with: startViewModel)
		self.navigationController.pushViewController(startViewController, animated: true)
	}
	func showListTableViewController(with listService: ListService) {
		let listViewModel = ListViewModel(with: listService)
		listViewModel
			.onModelSelected
			.sink { [weak self] model in self?.popToStart(with: model) }
			.store(in: &self.subscribers)
		let listTableViewController = ListTableViewController(viewModel: listViewModel)
		self.navigationController.pushViewController(listTableViewController, animated: true)
	}
	func showImagesViewController(with numberModel: NumberModel) {
		let imagesViewModel = ImagesViewModel(numberModel: numberModel)
		imagesViewModel
			.onItemSelected
			.map { ListService(listType: .cities) }
			.sink { [weak self] listService in self?.showListTableViewController(with: listService) }
			.store(in: &self.subscribers)
		let imagesViewController = ImagesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout(), viewModel: imagesViewModel)
		self.navigationController.pushViewController(imagesViewController, animated: true)
	}
}

private extension MainCoordinator {
	func popToStart(with model: Model) {
		guard let startViewController = self.navigationController.viewControllers.first as? StartViewController else { return }
		startViewController.viewModel.modelUpdated(model)
		self.navigationController.popToRootViewController(animated: true)
	}
}
