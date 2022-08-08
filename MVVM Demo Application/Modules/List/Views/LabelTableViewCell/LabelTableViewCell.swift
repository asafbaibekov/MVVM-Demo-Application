//
//  LabelTableViewCell.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

class LabelTableViewCell: UITableViewCell, Nibable, Reusable {

	var model: Model? {
		didSet {
			if let numberModel = model as? NumberModel {
				self.centeredLabel.text = String(numberModel.number)
			}
		}
	}

	@IBOutlet private var centeredLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state

	}
	
}
