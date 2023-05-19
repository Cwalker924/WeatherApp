//
//  LocationCellViewModel.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/19/23.
//

import Foundation

class LocationCellViewModel: Codable, Identifiable {
    let city: String
    let state: String?
    let lat: String
    let lon: String
    let flag: String?
    
    var coord: String {
        [lat, lon].joined(separator: ", ")
    }
    
    init(location: Location) {
        var city = location.name
        location.state == nil ? city.append("") : city.append(",")
        self.city = city
        state = location.state
        lat = location.lat
        lon = location.lon
        flag = LocationCellViewModel.getFlag(country: location.country)
    }
    
    private static func getFlag(country: String) -> String? {
        let base: UInt32 = 127397
        var s = ""
        for i in country.unicodeScalars {
            if let ucs = UnicodeScalar(base + i.value) {
                s.unicodeScalars.append(ucs)
            } else { return nil}
        }
        return String(s)
    }
}

extension LocationCellViewModel: Hashable {
    static func == (lhs: LocationCellViewModel, rhs: LocationCellViewModel) -> Bool {
        lhs.city == rhs.city && lhs.state == rhs.state
    }
    // Added Hasher because state is optional
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(String(city+(state ?? "")))
    }
}
