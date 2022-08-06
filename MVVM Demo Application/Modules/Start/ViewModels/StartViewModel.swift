//
//  StartViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit
import Combine

class StartViewModel: ViewModel {

	private(set) var numberModelUpdate: PassthroughSubject<NumberModel, Never>
	private(set) var onStartPressed: PassthroughSubject<Void, Never>
	private(set) var colorUpdate: PassthroughSubject<UIColor, Never>

	init() {
		self.numberModelUpdate = PassthroughSubject()
		self.onStartPressed = PassthroughSubject()
		self.colorUpdate = PassthroughSubject()
	}

	func numberModelUpdated(_ numberModel: NumberModel) {
		self.numberModelUpdate.send(numberModel)
	}

	@objc func startPressed() {
		self.onStartPressed.send(())
	}

	@objc func sixTapsPressed() {
		self.colorUpdate.send(.random)
	}

}
