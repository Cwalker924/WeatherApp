//
//  WeatherServicesTests.swift
//  WeatherAppTests
//
//  Created by Colton Walker on 5/18/23.
//

import XCTest
@testable import WeatherApp

final class WeatherServicesTests: XCTestCase {

    func testLocationGoodResponse() async {
        let client = MockHttpClient(endpoint: .goodLocationResponse)
        let locations = try? await WeatherServices(httpClient: client).getLocation(query: "")
        XCTAssertEqual(locations!.count, 5)
    }
    
    func testLocationBadResponse() async {
        do {
            let client = MockHttpClient(endpoint: .badLocationResponse)
            _ = try await WeatherServices(httpClient: client).getLocation(query: "")
            XCTFail("Should have thrown a decoding error")
        } catch {
            XCTAssertNotNil(error)
        }

    }
    
    func testWeatherGoodResponse() async {
        let client = MockHttpClient(endpoint: .goodWeatherResponse)
        let weather = try? await WeatherServices(httpClient: client).getWeather(lat: "", lon: "")
        XCTAssertEqual(weather!.name, "Oakland")
    }
    
    func testWeatherBadResponse() async {
        do {
            let client = MockHttpClient(endpoint: .badWeatherResponse)
            _ = try await WeatherServices(httpClient: client).getWeather(lat: "", lon: "")
            XCTFail("Should have thrown a decoding error")
        } catch {
            XCTAssertNotNil(error)
        }

    }
}
