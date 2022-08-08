//
//  ListViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation
import Combine

class ListViewModel: ViewModel {

	let service: Service

	private var subscribers = Set<AnyCancellable>()

	private(set) var models: [Model]

	@Published private(set) var isTextValid: Bool
	private(set) var onTextSubmited: PassthroughSubject<Void, Never>
	private(set) var onModelSelected: PassthroughSubject<Model, Never>

	init(service: Service) {
		self.service = service
		self.isTextValid = !(service is NumbersService)
		self.onTextSubmited = PassthroughSubject()
		self.onModelSelected = PassthroughSubject()
		self.models = [Model]()
	}

	func textChanged(text: String) {
		guard service is NumbersService else { return }
		let isTextValid = !text.isEmpty && text.allSatisfy({ $0.isNumber })
		if !isTextValid {
			self.models = []
		}
		self.isTextValid = isTextValid
	}

	func submited(with text: String) {
		guard isTextValid else { return }
		if let numbersService = service as? NumbersService {
			numbersService
				.getNumbers(to: Int(text)!)
				.replaceError(with: [])
				.sink(receiveValue: { [weak self] numberModels in
					self?.models = numberModels
					self?.onTextSubmited.send(())
				})
				.store(in: &self.subscribers)
		} else if let citiesService = service as? CitiesService {
			citiesService
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
