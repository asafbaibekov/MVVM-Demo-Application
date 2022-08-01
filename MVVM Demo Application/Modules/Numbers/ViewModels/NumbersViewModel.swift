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

	func numberOfRows(in section: Int) -> Int {
		return self.numberModels.count
	}

	func getNumberModel(at indexPath: IndexPath) -> NumberModel {
		return NumberModel(number: indexPath.row)
	}
}
