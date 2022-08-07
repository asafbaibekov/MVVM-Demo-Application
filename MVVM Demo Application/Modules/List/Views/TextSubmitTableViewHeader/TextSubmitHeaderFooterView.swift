//
//  TextSubmitHeaderFooterView.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

protocol TextSubmitHeaderFooterViewDelegate: AnyObject {
	func onSubmitPressed(_ textSubmitHeaderFooterView: TextSubmitHeaderFooterView, with text: String)
	func onTextChanged(_ textSubmitHeaderFooterView: TextSubmitHeaderFooterView, with text: String)
}

class TextSubmitHeaderFooterView: UITableViewHeaderFooterView, Nibable, Reusable {

	@IBOutlet private var textField: UITextField!

	@IBOutlet private var submitButton: UIButton!

	weak var delegate: TextSubmitHeaderFooterViewDelegate?

}

extension TextSubmitHeaderFooterView {
	@IBAction func textFieldDidChange(_ sender: UITextField) {
		self.delegate?.onTextChanged(self, with: sender.text ?? "")
	}

	@IBAction func submitPressed(_ sender: UIButton) {
		self.delegate?.onSubmitPressed(self, with: self.textField.text ?? "")
	}
}

extension TextSubmitHeaderFooterView: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder();
		return true
	}
}
