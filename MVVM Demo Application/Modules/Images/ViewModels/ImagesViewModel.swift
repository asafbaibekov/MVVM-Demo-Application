//
//  ImagesViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 06/08/2022.
//

import Foundation

class ImagesViewModel: ViewModel {

	private(set) var numberModel: NumberModel
	private(set) var imageModels: [ImageModel]

	init(numberModel: NumberModel) {
		self.numberModel = numberModel
		self.imageModels = (0...numberModel.number).map({ _ in ImageModel.example })
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

}
