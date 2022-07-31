//
//  Nibable.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

protocol Nibable {
	static func instantiate() -> Self
}

extension Nibable where Self: UIViewController {
	static func instantiate() -> Self {
		return Self(nibName: String(describing: self), bundle: .main)
	}
}

extension Nibable where Self: UIViewController, Self: ViewModelable {
	static func instantiate(with viewModel: VM) -> Self {
		return Self(nibName: String(describing: self), bundle: .main, viewModel: viewModel)
	}
}
