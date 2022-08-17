//
//  ImageCollectionViewCell.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 06/08/2022.
//

import UIKit
import Combine

class ImageCollectionViewCell: UICollectionViewCell, Nibable, Reusable {

	private var subscribers = Set<AnyCancellable>()

	var imageModel: ImageModel? {
		didSet {
			imageModel?
				.$image
				.compactMap { $0 }
				.assign(to: \.image, on: self.imageView)
				.store(in: &self.subscribers)
		}
	}

	@IBOutlet private var imageView: UIImageView!

	override func prepareForReuse() {
		super.prepareForReuse()
		self.imageView.image = nil
	}

}
