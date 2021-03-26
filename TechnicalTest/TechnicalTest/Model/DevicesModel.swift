//
//	DevicesModel.swift

import Foundation

struct DevicesModel : Codable {

	var devices : [Device]?

	enum CodingKeys: String, CodingKey {
		case devices = "devices"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		devices = try values.decodeIfPresent([Device].self, forKey: .devices)
	}
}
