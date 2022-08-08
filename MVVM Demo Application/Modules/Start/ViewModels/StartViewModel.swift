//
//  StartViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit
import Combine

class StartViewModel: ViewModel {

	@Published private(set) var model: Model?

	let onDataPassedPressed: PassthroughSubject<Model, Never>
	let onStartPressed: PassthroughSubject<Void, Never>
	let colorUpdate: PassthroughSubject<UIColor, Never>

	init() {
		self.onDataPassedPressed = PassthroughSubject()
		self.onStartPressed = PassthroughSubject()
		self.colorUpdate = PassthroughSubject()
	}

	func modelUpdated(_ model: Model) {
		self.model = model
	}

	@objc func dataPassedPressed() {
		guard let model = model else { return }
		self.onDataPassedPressed.send(model)
	}

	@objc func startPressed() {
		self.onStartPressed.send(())
	}

	@objc func sixTapsPressed() {
		self.colorUpdate.send(.random)
	}

}
