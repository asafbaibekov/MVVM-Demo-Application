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
		tableView.register(NumberTableViewCell.nib, forCellReuseIdentifier: NumberTableViewCell.reuseIdentifier)
	}
}

extension NumbersTableViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.viewModel.numberOfSections()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.tableView(numberOfRowsInSection: section)
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: NumberTableViewCell.reuseIdentifier, for: indexPath) as! NumberTableViewCell
		cell.numberModel = viewModel.getNumberModel(at: indexPath)
		return cell
	}
}
