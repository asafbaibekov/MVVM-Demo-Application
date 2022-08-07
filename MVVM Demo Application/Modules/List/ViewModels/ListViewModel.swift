//
//  ListViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation
import Combine

class ListViewModel: ViewModel {

	private(set) var models: [Model]

	@Published private(set) var isTextValid: Bool
	private(set) var onTextSubmited: PassthroughSubject<Void, Never>
	private(set) var onNumberSelected: PassthroughSubject<NumberModel, Never>

	init() {
		self.isTextValid = false
		self.onTextSubmited = PassthroughSubject()
		self.onNumberSelected = PassthroughSubject()
		self.models = [Model]()
	}

	func textChanged(text: String) {
		let isTextValid = !text.isEmpty && text.allSatisfy({ $0.isNumber })
		self.models = isTextValid ? Array(0..<Int(text)!).map(NumberModel.init) : []
		self.isTextValid = isTextValid
	}

	func submited() {
		self.onTextSubmited.send(())
	}

	func selected(numberModel: NumberModel) {
		self.onNumberSelected.send(numberModel)
	}

	func numberOfSections() -> Int {
		return 1
	}

	func numberOfRows(in section: Int) -> Int {
		return self.models.count
	}

	func getNumberModel(at indexPath: IndexPath) -> NumberModel {
		return NumberModel(number: indexPath.row)
	}
}
