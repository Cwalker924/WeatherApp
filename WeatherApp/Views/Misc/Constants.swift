//
//  Constants.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import Foundation

struct Constants {
    
    struct Search {
        static let searchBarHelperText = NSLocalizedString("Search City, State or Zip Code", comment: "Helper text that sits within the search bar during empty state")
        static let weatherSearchViewTitle = NSLocalizedString("Search Weather", comment: "The title for the weather search screen")
        static let noResult = NSLocalizedString("No results 😕", comment: "No results cell for search")
        static let recentSearches = NSLocalizedString("RECENT SEARCHES", comment: "Title for recently searched location list")
    }
    
    struct Weather {
        static let dayDetailsTitle = NSLocalizedString("TODAYS DETAILS", comment: "Title for current days forecast detail")
        static let forecastByTheHrTitle = NSLocalizedString("FORECAST BY THE HOUR", comment: "Title for hourly forecast")
        static let errorTitle = NSLocalizedString("Yikes! There was an error", comment: "Title for error view")
    }
    
    struct Misc {
        static let imageURLFormatter = NSLocalizedString("https://openweathermap.org/img/wn/%@@2x.png", comment: "Hard coded image URL resource where `%@` is the input")
        static let locationUDKey = "UserLocations"
        static let noAPIKeyErrorTitle = NSLocalizedString("No API Key", comment: "Title for no API Key error view")
        static let noAPIKeyError = NSLocalizedString("Sign Up for an API Key at \"openweathermap.org\"", comment: "Error for no API Key error view")
    }
}
