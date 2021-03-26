//
//	Device.swift

import Foundation

struct Device : Codable {

	let deviceName : String?
	let id : Int?
	let intensity : Int?
	let mode : String?
	let position : Int?
	let productType : String?
	let temperature : Int?


	enum CodingKeys: String, CodingKey {
		case deviceName = "deviceName"
		case id = "id"
		case intensity = "intensity"
		case mode = "mode"
		case position = "position"
		case productType = "productType"
		case temperature = "temperature"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		deviceName = try values.decodeIfPresent(String.self, forKey: .deviceName)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		intensity = try values.decodeIfPresent(Int.self, forKey: .intensity)
		mode = try values.decodeIfPresent(String.self, forKey: .mode)
		position = try values.decodeIfPresent(Int.self, forKey: .position)
		productType = try values.decodeIfPresent(String.self, forKey: .productType)
		temperature = try values.decodeIfPresent(Int.self, forKey: .temperature)
	}
}
