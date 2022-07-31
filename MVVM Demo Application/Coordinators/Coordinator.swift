//
//  Coordinator.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import UIKit

protocol Coordinator {
	var navigationController: UINavigationController { get set }
	var children: [Coordinator] { get set }
	func start()
}
