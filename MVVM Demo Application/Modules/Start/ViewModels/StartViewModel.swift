//
//  StartViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit
import Combine

class StartViewModel: ViewModel {

	@Published private(set) var numberModel: NumberModel?

	private(set) var onDataPassedPressed: PassthroughSubject<NumberModel, Never>
	private(set) var onStartPressed: PassthroughSubject<Void, Never>
	private(set) var colorUpdate: PassthroughSubject<UIColor, Never>

	init() {
		self.onDataPassedPressed = PassthroughSubject()
		self.onStartPressed = PassthroughSubject()
		self.colorUpdate = PassthroughSubject()
	}

	func numberModelUpdated(_ numberModel: NumberModel) {
		self.numberModel = numberModel
	}

	@objc func dataPassedPressed() {
		guard let numberModel = numberModel else { return }
		self.onDataPassedPressed.send(numberModel)
	}

	@objc func startPressed() {
		self.onStartPressed.send(())
	}

	@objc func sixTapsPressed() {
		self.colorUpdate.send(.random)
	}

}
