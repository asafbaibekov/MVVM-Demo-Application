//
//  StartViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation

class StartViewModel: ViewModel {

	weak private var mainCoordinate: MainCoordinator?

	init(mainCoordinate: MainCoordinator? = nil) {
		self.mainCoordinate = mainCoordinate
	}

	@objc func startPressed() {
		self.mainCoordinate?.showNumbersViewController()
	}

}
