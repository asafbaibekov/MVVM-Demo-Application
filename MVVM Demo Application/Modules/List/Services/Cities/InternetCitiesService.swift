//
//  InternetCitiesService.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 08/08/2022.
//

import Foundation
import Combine

class InternetCitiesService: CitiesService {
	let url: URL

	init(url: URL) {
		self.url = url
	}

	func getCities(with text: String) -> AnyPublisher<[CityModel], Error> {
		var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
		urlComponents.queryItems = [
			URLQueryItem(name: "resource_id", value: "5c78e9fa-c2e2-4771-93ff-7f400a12f7ba"),
			URLQueryItem(name: "q", value: text)
		]
		return URLSession.shared
			.dataTaskPublisher(for: urlComponents.url!)
			.map(\.data)
			.tryMap({ data in
				let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
				let result = json?["result"] as? [String : Any]
				return try JSONSerialization.data(withJSONObject: result?["records"] ?? [:], options: [])
			})
			.decode(type: [CityModel].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
}
