//
//  CityModel.swift
//  MVVM Demo Application
//
//  Created by Asaf Baibekov on 08/08/2022.
//

import Foundation

struct CityModel: Model, Codable {
	let id: Int
	let settlementSymbol: Int
	let settlementName: String
	let settlementForeignName: String

	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case settlementSymbol = "סמל_ישוב"
		case settlementName = "שם_ישוב"
		case settlementForeignName = "שם_ישוב_לועזי"
	}
}
