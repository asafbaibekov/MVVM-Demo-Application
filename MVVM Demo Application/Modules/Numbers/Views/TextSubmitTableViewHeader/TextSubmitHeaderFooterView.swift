//
//  TextSubmitHeaderFooterView.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

protocol TextSubmitHeaderFooterViewDelegate: AnyObject {
	func onSubmitPressed(_ textSubmitHeaderFooterView: TextSubmitHeaderFooterView, with text: String)
	func onTextChanged(_ textSubmitHeaderFooterView: TextSubmitHeaderFooterView, shouldChangeCharactersIn range: NSRange, replacementString string: String)
}

class TextSubmitHeaderFooterView: UITableViewHeaderFooterView, Nibable, Reusable {

	@IBOutlet private var textField: UITextField!

	@IBOutlet private var submitButton: UIButton!

	weak var delegate: TextSubmitHeaderFooterViewDelegate? {
		didSet {
			self.textField.delegate = self
			self.submitButton.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
		}
	}

}

extension TextSubmitHeaderFooterView {
	@objc func submitPressed() {
		self.delegate?.onSubmitPressed(self, with: textField?.text ?? "")
	}
}

extension TextSubmitHeaderFooterView: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		self.delegate?.onTextChanged(self, shouldChangeCharactersIn: range, replacementString: string)
		return true;
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder();
		return true;
	}
}
