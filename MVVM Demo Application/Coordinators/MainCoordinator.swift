//
//  MainCoordinator.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

class MainCoordinator: Coordinator {
	var navigationController: UINavigationController
	var children: [Coordinator]

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.children = [Coordinator]()
	}
	func start() {
		let startViewController = StartViewController.instantiate()
		self.navigationController.pushViewController(startViewController, animated: true)
	}
}
