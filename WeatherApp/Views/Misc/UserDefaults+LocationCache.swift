//
//  UserDefaults+LocationCache.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/18/23.
//

import Foundation

extension UserDefaults {
    func saveLocation(_ searchCellViewModel: LocationCellViewModel) {
        var locDict: [String: LocationCellViewModel] = [:]
        if let dict = getLocations() { locDict = dict }
        locDict[searchCellViewModel.city] = searchCellViewModel
        
        do {
            let data = try JSONEncoder().encode(locDict)
            setValue(data, forKey: Constants.Misc.locationUDKey)
            print("Save caching")
        } catch {
            assertionFailure("Failed to encode LocationCellViewModel.")
        }
    }

    func getLocations() -> [String: LocationCellViewModel]? {
        guard let data = object(forKey: Constants.Misc.locationUDKey) as? Data else { return nil }
        do {
            let searchCellViewModelsDict = try HTTPClient().decoder.decode([String: LocationCellViewModel].self, from: data)
            print("Get caching")
            return searchCellViewModelsDict
        } catch {
            assertionFailure("Failed to encode LocationCellViewModel array.")
            return nil
        }
    }
    
    func removeLocation(_ searchCellViewModel: LocationCellViewModel) {
        guard var locDict = getLocations() else { return }
        locDict.removeValue(forKey: searchCellViewModel.city)
        do {
            let data = try JSONEncoder().encode(locDict)
            setValue(data, forKey: Constants.Misc.locationUDKey)
            print("Save caching")
        } catch {
            assertionFailure("Failed to encode LocationCellViewModel.")
        }
    }
}
