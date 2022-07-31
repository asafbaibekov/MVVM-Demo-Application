//
//  ViewModelable.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

protocol ViewModelable {
	associatedtype VM: ViewModel
	var viewModel: VM! { get set }
}

extension ViewModelable where Self: UIViewController {
	init(viewModel: VM) {
		self.init()
		self.viewModel = viewModel
	}
	init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: VM) {
		self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		self.viewModel = viewModel
	}
}
