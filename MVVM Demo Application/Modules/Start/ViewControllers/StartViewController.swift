//
//  StartViewController.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

class StartViewController: UIViewController, Nibable, ViewModelable {

	var viewModel: StartViewModel!

	@IBOutlet weak var btnStart: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupViews()
	}

}

private extension StartViewController {
	func setupViews() {
		self.btnStart.addTarget(self.viewModel, action: #selector(StartViewModel.startPressed), for: .touchUpInside)
	}
}
