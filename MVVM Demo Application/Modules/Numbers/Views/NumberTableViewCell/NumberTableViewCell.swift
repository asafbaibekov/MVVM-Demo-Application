//
//  NumberTableViewCell.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

class NumberTableViewCell: UITableViewCell, Nibable, Reusable {

	@IBOutlet private var numberLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state

	}
	
}
