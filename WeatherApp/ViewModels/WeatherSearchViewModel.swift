//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import Combine
import Foundation
import SwiftUI

class WeatherSearchViewModel: ObservableObject {
    enum State { case empty, noAPIKey, cells([LocationCellViewModel]) }
    @Published var state: State = .empty
    // Search
    @Published var searchCellViewModels: [LocationCellViewModel] = []
    @Published var showSearchResult: Bool = false
    @Published var locationQuery: String = "" {
        didSet {
            if locationQuery.isEmpty { searchCellViewModels = [] }
            showSearchResult = !searchCellViewModels.isEmpty || !locationQuery.isEmpty
        }
    }
    @Published var usersLocations: [LocationCellViewModel] = [] {
        didSet {
            state = usersLocations.isEmpty ?
                .empty :
                .cells(usersLocations.sorted(by: { $0.city < $1.city }))
        }
    }
    var showShowNoResultCell: Bool {
        showSearchResult &&
        locationQuery.count >= 1 &&
        searchCellViewModels.isEmpty
    }

    // Used to pass the selected Location to the parent coordinator
    var selectedLocation = PassthroughSubject<LocationCellViewModel, Never>()
    
    private let service: WeatherServices
    private let locationManager: LocationManager
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: WeatherServices = WeatherServices(), locationManager: LocationManager = LocationManager()) {
        self.service = service
        self.locationManager = locationManager
        setUpSubscriptions()
    }
    
    // Ask permission and gets current location
    func getLocation() {
        locationManager.getLocation()
    }

    // Gets cached locations
    func getUsersSavedLocations() {
        guard HTTPClient.hasAPIKey else { state = .noAPIKey; return}
        
        if let savedLocationsDict = UserDefaults.standard.getLocations() {
            self.usersLocations = savedLocationsDict.values.map { $0 }
        } else {
            state = .empty
        }
    }
    
    func setUpSubscriptions() {
        locationManager.zipCode.sink { [weak self] zipCode in
            guard let self = self else { return }
            self.getLocation(query: zipCode)
            self.locationQuery = zipCode
        }.store(in: &subscriptions)
    }
    
    // Navigation methods
    func navigateToWeatherView(_ selection: LocationCellViewModel) {
        selectedLocation.send(selection)
    }
    
    func saveLocation(_ selection: LocationCellViewModel) {
        UserDefaults.standard.saveLocation(selection)
    }
    
    
}

// Services
extension WeatherSearchViewModel {
    func getLocation(query: String) {
        guard !query.isEmpty else { return }
        Task {
            do {
                let locations: [Location]
                if let _ = Int(query) {
                    locations = try await service.getLocation(zip: query)
                } else {
                    locations = try await service.getLocation(query: query)
                }

                await MainActor.run(body: { [weak self] in
                    // translate the models into viewModels
                    let searchCellViewModels = locations.compactMap { LocationCellViewModel(location: $0) }
                    self?.searchCellViewModels = searchCellViewModels
                })
            } catch {
                // If theres an error with search, lets just fail
                // silently since we show the `no results` cell anyway
                print(error.localizedDescription)
            }
        }
    }
}

// Location cell methods
extension WeatherSearchViewModel {
    func cellIsSelected(_ searchCellViewModel: LocationCellViewModel) -> Bool {
        usersLocations.contains(where: { $0 == searchCellViewModel } )
    }
    
    func remove(at offsets: IndexSet) {
        if let deletedLocation = offsets.map({ usersLocations[$0] }).first {
            UserDefaults.standard.removeLocation(deletedLocation)
        }
        usersLocations.remove(atOffsets: offsets)
    }
}
