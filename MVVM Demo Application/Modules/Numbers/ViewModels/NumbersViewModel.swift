//
//  NumbersViewModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 31/07/2022.
//

import Foundation

class NumbersViewModel: ViewModel {

	func numberOfSections() -> Int {
		return 1
	}

	func tableView(numberOfRowsInSection section: Int) -> Int {
		return 10
	}
}
