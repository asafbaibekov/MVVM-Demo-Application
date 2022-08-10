//
//  ListViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation
import Combine

class ListViewModel: ViewModel {

	private let listService: ListService

	private var subscribers = Set<AnyCancellable>()

	private var models: [Model]

	@Published private(set) var isTextValid: Bool
	let onTextSubmited: PassthroughSubject<Void, Never>
	let onModelSelected: PassthroughSubject<Model, Never>

	init(with listService: ListService) {
		self.listService = listService
		self.isTextValid = listService.listType != .numbers
		self.onTextSubmited = PassthroughSubject()
		self.onModelSelected = PassthroughSubject()
		self.models = [Model]()
	}

	func textChanged(text: String) {
		guard listService.listType == .numbers else { return }
		let isTextValid = !text.isEmpty && text.allSatisfy({ $0.isNumber })
		if !isTextValid {
			self.models = []
		}
		self.isTextValid = isTextValid
	}

	func submited(with text: String) {
		guard isTextValid else { return }
		switch listService.listType {
		case .numbers:
			listService
				.getNumbers(to: Int(text)!)
				.replaceError(with: [])
				.sink(receiveValue: { [weak self] numberModels in
					self?.models = numberModels
					self?.onTextSubmited.send(())
				})
				.store(in: &self.subscribers)
		case .cities:
			listService
				.getCities(with: text)
				.replaceError(with: [])
				.sink(receiveValue: { [weak self] cityModels in
					self?.models = cityModels
					self?.onTextSubmited.send(())
				})
				.store(in: &self.subscribers)
		}
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
