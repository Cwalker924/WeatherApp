//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import Foundation

/// api key 91030a6179aab5e4628c4947fc045387
///
/// Endpoints
enum Endpoints: String {
    case weather = "https://api.openweathermap.org/data/2.5"
    case locationList = "http://api.openweathermap.org/geo/1.0"
    var url: URL {
        URL(string: rawValue)!
    }
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

class HTTPClient: NSObject {
    static let shared = HTTPClient()
    
    // Added custom decoder as to not need
    // coding keys for each embedded object
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    static var hasAPIKey: Bool {
        !APIKeys.openWeatherAPIKey.isEmpty
    }
    
    func get(url: URL) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpUrlResponse = response as? HTTPURLResponse, !(200...299).contains(httpUrlResponse.statusCode) {
                // Can pass to a status code parser and return human readable response
                throw URLError(.badServerResponse)
            }
            return data
        } catch {
            throw URLError(.badURL)
        }
    }
}
