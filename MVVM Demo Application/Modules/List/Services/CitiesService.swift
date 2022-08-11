//
//  CitiesService.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 08/08/2022.
//

import Foundation
import Combine

protocol CitiesService: Service {
	func getCities(with text: String) -> AnyPublisher<[CityModel], Error>
}
