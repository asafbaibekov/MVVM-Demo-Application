//
//  NumbersTableViewController.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

class NumbersTableViewController: UITableViewController, ViewModelable {

	var viewModel: NumbersViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupViews()
	}

}


private extension NumbersTableViewController {
	func setupViews() {
		tableView.register(TextSubmitHeaderFooterView.nib, forHeaderFooterViewReuseIdentifier: TextSubmitHeaderFooterView.reuseIdentifier)
		tableView.register(NumberTableViewCell.nib, forCellReuseIdentifier: NumberTableViewCell.reuseIdentifier)
	}
}

extension NumbersTableViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.viewModel.numberOfSections()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.numberOfRows(in: section)
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: NumberTableViewCell.reuseIdentifier, for: indexPath) as! NumberTableViewCell
		cell.numberModel = viewModel.getNumberModel(at: indexPath)
		return cell
	}

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let textSubmitHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TextSubmitHeaderFooterView.reuseIdentifier) as! TextSubmitHeaderFooterView
		textSubmitHeaderFooterView.delegate = self
		return textSubmitHeaderFooterView
	}
	
}

extension NumbersTableViewController: TextSubmitHeaderFooterViewDelegate {
	func onTextChanged(_ textSubmitHeaderFooterView: TextSubmitHeaderFooterView, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
		
	}
	
	func onSubmitPressed(_ textSubmitHeaderFooterView: TextSubmitHeaderFooterView, with text: String) {
		
	}
}
