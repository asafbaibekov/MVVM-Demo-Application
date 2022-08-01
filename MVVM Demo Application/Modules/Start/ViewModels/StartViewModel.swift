//
//  StartViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation
import Combine

class StartViewModel: ViewModel {

	var numberModelUpdate: PassthroughSubject<NumberModel, Never>

	weak private var mainCoordinate: MainCoordinator?

	init(mainCoordinate: MainCoordinator? = nil) {
		self.mainCoordinate = mainCoordinate
		self.numberModelUpdate = PassthroughSubject()
	}

	func numberModelUpdated(_ numberModel: NumberModel) {
		self.numberModelUpdate.send(numberModel)
	}

	@objc func startPressed() {
		self.mainCoordinate?.showNumbersViewController()
	}

}
