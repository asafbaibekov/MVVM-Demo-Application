//
//  NumbersViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation
import Combine

class NumbersViewModel: ViewModel {

	private(set) var numberModels: [NumberModel]

	@Published var isTextValid: Bool
	private(set) var onTextSubmited: PassthroughSubject<Void, Never>

	private weak var mainCoordinate: MainCoordinator?

	init(mainCoordinate: MainCoordinator) {
		self.mainCoordinate = mainCoordinate
		self.isTextValid = false
		self.onTextSubmited = PassthroughSubject()
		self.numberModels = [NumberModel]()
	}

	func textChanged(text: String) {
		let isTextValid = !text.isEmpty && text.allSatisfy({ $0.isNumber })
		self.numberModels = isTextValid ? Array(0..<Int(text)!).map(NumberModel.init) : []
		self.isTextValid = isTextValid
	}

	func submited() {
		self.onTextSubmited.send(())
	}

	func numberOfSections() -> Int {
		return 1
	}

	func numberOfRows(in section: Int) -> Int {
		return self.numberModels.count
	}

	func getNumberModel(at indexPath: IndexPath) -> NumberModel {
		return NumberModel(number: indexPath.row)
	}
}
