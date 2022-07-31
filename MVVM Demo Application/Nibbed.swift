//
//  Nibbed.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

protocol Nibbed {
	static func instantiate() -> Self
}

extension Nibbed where Self: UIViewController {
	static func instantiate() -> Self {
		return Self(nibName: String(describing: self), bundle: .main)
	}
}
