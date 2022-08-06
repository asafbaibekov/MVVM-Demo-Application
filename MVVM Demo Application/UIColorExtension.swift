//
//  UIColorExtension.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 06/08/2022.
//

import UIKit

extension UIColor {
	class var random: UIColor { UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1) }
}
