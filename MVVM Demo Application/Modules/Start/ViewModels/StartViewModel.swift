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

	private let onDataPassedPressedSubject: PassthroughSubject<Model, Never>
	private let onStartPressedSubject: PassthroughSubject<Void, Never>
	private let colorUpdateSubject: PassthroughSubject<UIColor, Never>
	lazy var onDataPassedPressed = onDataPassedPressedSubject.eraseToAnyPublisher()
	lazy var onStartPressed = onStartPressedSubject.eraseToAnyPublisher()
	lazy var colorUpdate = colorUpdateSubject.eraseToAnyPublisher()

	init() {
		self.onDataPassedPressedSubject = PassthroughSubject()
		self.onStartPressedSubject = PassthroughSubject()
		self.colorUpdateSubject = PassthroughSubject()
	}

	func modelUpdated(_ model: Model) {
		self.model = model
	}

	@objc func dataPassedPressed() {
		guard let model = model else { return }
		self.onDataPassedPressedSubject.send(model)
	}

	@objc func startPressed() {
		self.onStartPressedSubject.send(())
	}

	@objc func sixTapsPressed() {
		self.colorUpdateSubject.send(.random)
	}

}
