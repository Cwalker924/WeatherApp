//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/18/23.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject  {
    let manager = CLLocationManager()
    
    var location: CLLocationCoordinate2D?
    var zipCode = PassthroughSubject<String, Never>()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func getLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    func getZip(for coord: CLLocationCoordinate2D) {
        let clLocation = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        CLGeocoder().reverseGeocodeLocation(clLocation, completionHandler: {[weak self] placemarks, error in
            guard let self = self else { return }
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }

            if let placemark = placemarks?.first, let zipCode = placemark.postalCode {
                self.zipCode.send(zipCode)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = locations.first?.coordinate else { return }
        getZip(for: coord)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
}
