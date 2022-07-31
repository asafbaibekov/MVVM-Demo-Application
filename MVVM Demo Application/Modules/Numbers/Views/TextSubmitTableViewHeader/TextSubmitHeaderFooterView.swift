//
//  TextSubmitHeaderFooterView.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

class TextSubmitHeaderFooterView: UITableViewHeaderFooterView, Nibable, Reusable {

	@IBOutlet private var textField: UITextField!

	@IBOutlet private var submitButton: UIButton!

}
