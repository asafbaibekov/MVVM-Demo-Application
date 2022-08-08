//
//  ListTableViewController.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit
import Combine

class ListTableViewController: UITableViewController, ViewModelable {

	var viewModel: ListViewModel!

	private var subscribers = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupViews()
		setupCombine()
	}

}


private extension ListTableViewController {
	func setupViews() {
		tableView.register(TextSubmitHeaderFooterView.nib, forHeaderFooterViewReuseIdentifier: TextSubmitHeaderFooterView.reuseIdentifier)
		tableView.register(LabelTableViewCell.nib, forCellReuseIdentifier: LabelTableViewCell.reuseIdentifier)
	}

	func setupCombine() {
		self.viewModel
			.$isTextValid
			.sink(receiveValue: { [weak self] isTextValid in
				self?.view.backgroundColor = isTextValid ? .white : .red
				if !isTextValid {
					self?.tableView.reloadData()
				}
			})
			.store(in: &self.subscribers)

		self.viewModel
			.onTextSubmited
			.sink { [weak self] in
				self?.tableView.reloadData()
			}
			.store(in: &self.subscribers)
	}
}

extension ListTableViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.viewModel.numberOfSections()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.numberOfRows(in: section)
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.reuseIdentifier, for: indexPath) as! LabelTableViewCell
		cell.model = viewModel.getModel(at: indexPath) as? NumberModel
		return cell
	}

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let textSubmitHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TextSubmitHeaderFooterView.reuseIdentifier) as! TextSubmitHeaderFooterView
		textSubmitHeaderFooterView.delegate = self
		return textSubmitHeaderFooterView
	}
	
}

extension ListTableViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let textTableViewCell = tableView.cellForRow(at: indexPath) as? LabelTableViewCell else { return }
		self.viewModel.selected(model: textTableViewCell.model)
	}
}

extension ListTableViewController: TextSubmitHeaderFooterViewDelegate {
	func onTextChanged(_ textSubmitHeaderFooterView: TextSubmitHeaderFooterView, with text: String) {
		self.viewModel.textChanged(text: text)
	}
	
	func onSubmitPressed(_ textSubmitHeaderFooterView: TextSubmitHeaderFooterView, with text: String) {
		self.viewModel.submited()
	}
}
