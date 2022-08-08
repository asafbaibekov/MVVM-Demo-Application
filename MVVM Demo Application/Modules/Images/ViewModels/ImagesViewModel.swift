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
	let onItemSelected: PassthroughSubject<Void, Never>
	let itemDeleted: PassthroughSubject<IndexPath, Never>

	init(numberModel: NumberModel) {
		self.imageModels = numberModel.number >= 1 ? (1...numberModel.number).map({ _ in ImageModel.example }) : []
		self.itemDeleted = PassthroughSubject()
		self.onItemSelected = PassthroughSubject()
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
		self.itemDeleted.send(indexPath)
	}

	func itemSelected() {
		self.onItemSelected.send()
	}
}
