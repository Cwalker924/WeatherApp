//
//  Location.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import Foundation

struct Location: Codable {
    let name: String
    let lat: String
    let lon: String
    let country: String
    let state: String?
    let zip: String?
    
    init(name: String, lat: String, lon: String, country: String, state: String?, zip: String?) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
        self.zip = zip
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let lat = try container.decode(Float.self, forKey: .lat)
        self.lat = String(lat) // Convert Float value to String
        let lon = try container.decode(Float.self, forKey: .lon)
        self.lon = String(lon) // Convert Float value to String
        self.country = try container.decode(String.self, forKey: .country)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        self.zip = try container.decodeIfPresent(String.self, forKey: .zip)
    }
}
