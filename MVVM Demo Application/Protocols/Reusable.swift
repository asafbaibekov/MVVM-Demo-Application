//
//  Reusable.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation
import UIKit

protocol Reusable {
	static var reuseIdentifier: String { get }
}

extension Reusable {
	static var reuseIdentifier: String { String(describing: self) }
}
