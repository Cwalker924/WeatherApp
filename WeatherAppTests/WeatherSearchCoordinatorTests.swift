//
//  WeatherSearchCoordinatorTests.swift
//  WeatherAppTests
//
//  Created by Colton Walker on 5/18/23.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherSearchCoordinatorTests: XCTestCase {
    var coord: WeatherSearchCoordinator?
    let nav = UINavigationController()
    var vm: WeatherSearchViewModel?
    var subscriptions = Set<AnyCancellable>()
    
    func testNavigationPublisher() {
        let expectation = XCTestExpectation(description: "Publishes one value then fails")
        var value: LocationCellViewModel?
        
        coord = WeatherSearchCoordinator(navigationController: nav, parent: nil)
        vm = coord?.viewModel
        let location = Location(name: "Oakland", lat: "", lon: "", country: "US", state: "CA", zip: nil)
        let searchCellViewModel = LocationCellViewModel(location: location)

        vm?.selectedLocation.sink(receiveValue: { searchCellViewModel in
            value = searchCellViewModel
            expectation.fulfill()
        })
        .store(in: &subscriptions)
        
        vm?.navigateToWeatherView(searchCellViewModel)
        
        wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(value?.city, searchCellViewModel.city)
    }
}
