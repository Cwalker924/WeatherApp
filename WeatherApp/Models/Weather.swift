//
//  Weather.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import Foundation

struct Weather: Codable {
    let coord: Coord?
    let weather: [WeatherMetaData]?
    let base: String?// internal param
    let main: WeatherMain?
    let visibility: Int?
    let wind: WeatherWind?
    let rain: WeatherRain?
    let clouds: WeatherCloud?
    let dt: Date? //Time of data calculation, unix, UTC
    let sys: WeatherSys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}

extension Weather {
    struct Coord: Codable {
        let lon: Float
        let lat: Float
        
        init(lon: Float, lat: Float) {
            self.lon = lon
            self.lat = lat
        }
    }
    
    struct WeatherMetaData: Codable {
        let id: Int?
        let main: String?
        let description: String?
        let icon: String?
    }
    
    struct WeatherMain: Codable {
        let temp: Double?
        let feelsLike: Double?
        let tempMin: Double?
        let tempMax: Double?
        let pressure: Int?
        let humidity: Int?
        let seaLevel: Int?
        let grndLevel: Int?
    }
    
    struct WeatherWind: Codable {
        let speed: Double?
        let deg: Double?
        let gust: Double?
    }
    
    struct WeatherRain: Codable {
        let oneHr: Double?
    }
    
    struct WeatherCloud: Codable {
        let all: Double?
    }
    
    struct WeatherSys: Codable {
        let type: Int?
        let id: Int?
        let country: String?
        let sunrise: Date?
        let sunset: Date?
    }
}
