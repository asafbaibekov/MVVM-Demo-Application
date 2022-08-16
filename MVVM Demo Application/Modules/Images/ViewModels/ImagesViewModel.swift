//
//  ImagesViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 06/08/2022.
//

import Foundation
import Combine

class ImagesViewModel: ViewModel {

	private var imageModels: [ImageModel]

	private let onItemSelectedSubject: PassthroughSubject<Void, Never>
	private let itemDeletedSubject: PassthroughSubject<IndexPath, Never>
	lazy var onItemSelected = onItemSelectedSubject.eraseToAnyPublisher()
	lazy var itemDeleted = itemDeletedSubject.eraseToAnyPublisher()

	init(numberModel: NumberModel) {
		self.imageModels = numberModel.number >= 1 ? (1...numberModel.number).map({ _ in ImageModel.example }) : []
		self.itemDeletedSubject = PassthroughSubject()
		self.onItemSelectedSubject = PassthroughSubject()
	}

	func numberOfSections() -> Int {
		return 1
	}

	func numberOfItems(in section: Int) -> Int {
		return self.imageModels.count
	}

	func getImageModel(at indexPath: IndexPath) -> ImageModel {
		return self.imageModels[indexPath.item]
	}

	func deleteItem(at indexPath: IndexPath) {
		self.imageModels.remove(at: indexPath.item)
		self.itemDeletedSubject.send(indexPath)
	}

	func itemSelected() {
		self.onItemSelectedSubject.send()
	}
}
