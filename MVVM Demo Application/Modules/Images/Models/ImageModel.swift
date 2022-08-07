//
//  ImageModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 06/08/2022.
//

import UIKit
import EzImageLoader

class ImageModel: Model {

	let imageURL: URL
	@Published private(set) var image: UIImage?

	init(imageURL: URL) {
		self.imageURL = imageURL
		ImageLoader.reset()
		ImageLoader.get(
			imageURL,
			completion: { [weak self] result in
				self?.image = result.image
			}
		)
	}

	static var example: ImageModel { ImageModel(imageURL: URL(string: "https://picsum.photos/200")!) }
}
