//
//  WeatherServices.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import Foundation
import Contacts

enum WeatherServicesError: Error {
    case badURLQuery
}

class WeatherServices {
    
    private enum Paths: String {
        case direct = "/direct"
        case zip = "/zip"
        case weather = "/weather"
    }
    
    private enum QueryArgs: String {
        case query = "q"
        case limit = "limit"
        case zip = "zip"
        case lat = "lat"
        case lon = "lon"
        case apiKey = "appid"
        case units = "units"
    }
    
    private var queryItems = [
        URLQueryItem(name: QueryArgs.units.rawValue, value: "imperial"),
        URLQueryItem(name: QueryArgs.apiKey.rawValue, value: APIKeys.openWeatherAPIKey)
    ]
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = .shared) {
        self.httpClient = httpClient
    }

    func getLocation(query: String) async throws -> [Location] {
        do {
            var queryItems = queryItems
            queryItems.append(URLQueryItem(name: QueryArgs.query.rawValue, value: query))
            queryItems.append(URLQueryItem(name: QueryArgs.limit.rawValue, value: "5"))
                
            var urlComponent = URLComponents(url: Endpoints.locationList.url, resolvingAgainstBaseURL: false)
            urlComponent?.queryItems = queryItems
            let urlWithPath = urlComponent?.url?.appendingPathComponent(Paths.direct.rawValue)
            guard let url = urlWithPath else { throw URLError(.unsupportedURL) } // TODO: Add custom error?

            let data = try await httpClient.get(url: url)
            let locations = try httpClient.decoder.decode([Location].self, from: data)
            
            return locations
        } catch {
            throw WeatherServicesError.badURLQuery
        }
    }
    
    func getLocation(zip: String) async throws -> [Location] {
        do {
            var queryItems = queryItems
            queryItems.append(URLQueryItem(name: QueryArgs.zip.rawValue, value: zip))
            
            var urlComponent = URLComponents(url: Endpoints.locationList.url, resolvingAgainstBaseURL: false)
            urlComponent?.queryItems = queryItems
            let urlWithPath = urlComponent?.url?.appendingPathComponent(Paths.zip.rawValue)
            guard let url = urlWithPath else { throw URLError(.unsupportedURL) } // TODO: Add custom error?

            let data = try await httpClient.get(url: url)
            let location = try httpClient.decoder.decode(Location.self, from: data)
            return [location]
        } catch {
            throw WeatherServicesError.badURLQuery
        }
    }
    
    // Should pass an object rather than two separate strings
    func getWeather(lat: String, lon: String) async throws -> Weather {
        do {
            var queryItems = queryItems
            queryItems.append(URLQueryItem(name: QueryArgs.lat.rawValue, value: lat))
            queryItems.append(URLQueryItem(name: QueryArgs.lon.rawValue, value: lon))
            
            var urlComponent = URLComponents(url: Endpoints.weather.url, resolvingAgainstBaseURL: false)
            urlComponent?.queryItems = queryItems
            let urlWithPath = urlComponent?.url?.appendingPathComponent(Paths.weather.rawValue)
            guard let url = urlWithPath else { throw URLError(.unsupportedURL) } // TODO: Add custom error?
            
            let data = try await httpClient.get(url: url)
            let weather = try httpClient.decoder.decode(Weather.self, from: data)
            
            return weather
        } catch {
            throw WeatherServicesError.badURLQuery
        }
    }
}
