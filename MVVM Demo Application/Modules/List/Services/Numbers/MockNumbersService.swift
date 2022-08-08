//
//  MockNumbersService.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 08/08/2022.
//

import Foundation
import Combine

class MockNumbersService: NumbersService {
	func getNumbers(to number: Int) -> AnyPublisher<[NumberModel], Error> {
		return Just(Array(0...number).map(NumberModel.init))
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}
}
