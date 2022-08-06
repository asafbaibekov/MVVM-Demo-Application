//
//  StartViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation
import Combine

class StartViewModel: ViewModel {

	private(set) var numberModelUpdate: PassthroughSubject<NumberModel, Never>
	private(set) var onStartPressed: PassthroughSubject<Void, Never>

	init() {
		self.numberModelUpdate = PassthroughSubject()
		self.onStartPressed = PassthroughSubject()
	}

	func numberModelUpdated(_ numberModel: NumberModel) {
		self.numberModelUpdate.send(numberModel)
	}

	@objc func startPressed() {
		self.onStartPressed.send(())
	}

}
