//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/17/23.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var state: State  = .loading
    enum State { case configured, loading, error(Error) }
    
    @Published var city: String = ""
    @Published var weatherDescription = ""
    @Published var degrees: String = ""
    @Published var iconURL: URL?
    @Published var highTemp: String = ""
    @Published var lowTemp: String = ""
    @Published var sunrise: String = ""
    @Published var sunset: String = ""
    @Published var windSpeed: String = ""
    @Published var humidity: String = ""
    
    // These to fake data
    @Published var dummyHrs: [String] = []
    @Published var dummyTemp: [String] = []
    @Published var dummyIcons: [String] = [
        "sun.max.fill",
        "cloud.fill",
        "cloud.drizzle.fill",
        "cloud.rain.fill",
        "cloud.snow.fill",
        "cloud.bolt.fill",
        "cloud.bolt.rain.fill",
        "cloud.sun.fill",
        "cloud.sun.rain.fill",
        "smoke.fill"
    ]
    
    let service: WeatherServices
    
    // Saving these locally so we can pull to refresh!
    let lat: String
    let lon: String
    
    init(lat: String, lon: String, service: WeatherServices = WeatherServices()) {
        self.service = service
        self.lat = lat
        self.lon = lon
        getWeather(lat, lon)
    }
    
    func getWeather(_ lat: String, _ lon: String) {
        state = .loading
        Task {
            do {
                let weather = try await service.getWeather(lat: lat, lon: lon)
                await MainActor.run(body: {
                    withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                        state = .configured
                        self.configure(weather: weather)
                    }
                })
            } catch {
                // TODO: Error state
                await MainActor.run(body: {
                    print(error.localizedDescription)
                    state = .error(error)
                })
            }
        }
    }
    
    func refresh() {
        getWeather(lat, lon)
    }
    
    func configure(weather: Weather) {
        city = weather.name ?? ""
        weatherDescription = weather.weather?.first?.description ?? ""
        degrees = configureDegree(weather.main?.temp)
        iconURL = getWeatherIconURL(weather.weather?.first?.icon)
        highTemp = configureDegree(weather.main?.tempMax)
        lowTemp = configureDegree(weather.main?.tempMin)
        sunrise = configureDateTime(weather.sys?.sunrise)
        sunset = configureDateTime(weather.sys?.sunset)
        windSpeed = configureWind(weather.wind?.speed)
        if let intHumidity = weather.main?.humidity {
            self.humidity = String(intHumidity)
        }
        dummyHrs = getDummyDates()
        dummyTemp = getDummyTemp(weather.main?.temp ?? 64)
    }
    
    private func getWeatherIconURL(_ iconCode: String?) -> URL? {
        guard let iconCode = iconCode else { return nil }
        let formattedURLString = String(format: Constants.Misc.imageURLFormatter, iconCode)
        return URL(string: formattedURLString)
    }
    
    private func configureDegree(_ temp: Double?) -> String {
        guard var temp = temp else { return "" }
        temp = temp.rounded(.towardZero)
        let mf = MeasurementFormatter()
        let degrees = Measurement(value: temp, unit: UnitTemperature.fahrenheit)
        return mf.string(from: degrees)
    }
    
    private func configureDateTime(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: date)
    }
    
    private func configureWind(_ speed: Double?) -> String {
        guard var speed = speed else { return "" }
        speed = speed.rounded(.towardZero)
        let value = NSMeasurement(doubleValue: speed, unit: UnitSpeed.milesPerHour)
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter.string(from: value as Measurement<Unit>)
    }
}

// These methods are constructors for fake data
extension WeatherViewModel {
    private func getDummyDates() -> [String] {
        var dateStringArr = [String]()
        for hr in stride(from: 1, through: 13, by: 1) {
            let getFutureTime = getFutureDate(hr)
            dateStringArr.append(configureDateTime(getFutureTime))
        }
        return dateStringArr
    }
    
    private func getFutureDate(_ hr: Int) -> Date? {
        return Calendar.current.date(
            byAdding: .hour,
            value: hr,
            to: Date())
    }
    
    // Creates an array of temps around a given temp
    // This is so the dummy data appears more believable
    // and somewhat dynamic
    private func getDummyTemp(_ mainTemp: Double) -> [String] {
        let startRange = Int(mainTemp - 5)
        let endRange = Int(mainTemp + 5)
        let range = (startRange...endRange).map { Double($0) }
        
        var tempArr = [String]()
        for _ in stride(from: 1, through: 12, by: 1) {
            let randomTemp = configureDegree(range.randomElement())
            tempArr.append(randomTemp)
        }

        return tempArr
    }
}
