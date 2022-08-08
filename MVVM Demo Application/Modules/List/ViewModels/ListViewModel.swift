//
//  ListViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation
import Combine

class ListViewModel: ViewModel {

	private let listType: ListType

	private(set) var models: [Model]

	@Published private(set) var isTextValid: Bool
	private(set) var onTextSubmited: PassthroughSubject<Void, Never>
	private(set) var onModelSelected: PassthroughSubject<Model, Never>

	init(listType: ListType) {
		self.listType = listType
		self.isTextValid = false
		self.onTextSubmited = PassthroughSubject()
		self.onModelSelected = PassthroughSubject()
		self.models = [Model]()
	}

	func textChanged(text: String) {
		switch listType {
		case .numbers:
			let isTextValid = !text.isEmpty && text.allSatisfy({ $0.isNumber })
			self.models = isTextValid ? Array(0..<Int(text)!).map(NumberModel.init) : []
			self.isTextValid = isTextValid
		}
	}

	func submited() {
		self.onTextSubmited.send(())
	}

	func selected(model: Model?) {
		guard let model = model else { return }
		self.onModelSelected.send(model)
	}

	func numberOfSections() -> Int {
		return 1
	}

	func numberOfRows(in section: Int) -> Int {
		return self.models.count
	}

	func getModel(at indexPath: IndexPath) -> Model? {
		return self.models[indexPath.row]
	}
}
