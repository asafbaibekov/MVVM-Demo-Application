//
//  NumbersService.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 08/08/2022.
//

import Foundation
import Combine

protocol NumbersService: Service {
	func getNumbers(to number: Int) -> AnyPublisher<[NumberModel], Error>
}
