//
//  MockHttpClient.swift
//  WeatherAppTests
//
//  Created by Colton Walker on 5/18/23.
//

import XCTest
@testable import WeatherApp

final class MockHttpClient: HTTPClient {
    let endpoint: TestEndpoints
    
    enum TestEndpoints: String {
        case goodLocationResponse
        case badLocationResponse
        
        case goodWeatherResponse
        case badWeatherResponse
    }

    override func get(url: URL) async throws -> Data {
        switch endpoint {
        case .goodLocationResponse: return goodLocationResponse
        case .badLocationResponse: return badLocationResponse
            
        case .goodWeatherResponse: return goodWeatherResponse
        case .badWeatherResponse: return badWeatherResponse
        }
    }
    
    init(endpoint: TestEndpoints) {
        self.endpoint = endpoint
    }
    
    let goodLocationResponse: Data = """
           [
               {
                   "name": "Oakland",
                   "local_names": {
                       "yo": "Oakland",
                       "oc": "Oakland",
                       "sk": "Oakland",
                       "no": "Oakland",
                       "ka": "ოკლენდი",
                       "eu": "Oakland",
                       "id": "Oakland",
                       "is": "Oakland",
                       "sv": "Oakland",
                       "ga": "Oakland",
                       "mg": "Oakland",
                       "bn": "ওকল্যান্ড",
                       "fr": "Oakland",
                       "sh": "Oakland",
                       "ne": "ओकल्याण्ड",
                       "tt": "Оукленд",
                       "tr": "Oakland",
                       "cy": "Oakland",
                       "ur": "اوکلینڈ، کیلیفورنیا",
                       "hy": "Օքլենդ",
                       "ko": "오클랜드",
                       "vi": "Oakland",
                       "li": "Oakland",
                       "la": "Quercupolis",
                       "sr": "Оукланд",
                       "sw": "Oakland",
                       "mr": "ओकलंड",
                       "gl": "Oakland",
                       "he": "אוקלנד (קליפורניה)",
                       "it": "Oakland",
                       "af": "Oakland",
                       "sq": "Oakland",
                       "ja": "オークランド",
                       "hr": "Oakland",
                       "sl": "Oakland",
                       "jv": "Oakland",
                       "ro": "Oakland",
                       "ht": "Oakland",
                       "io": "Oakland",
                       "ie": "Oakland",
                       "zh": "奥克兰/奧克蘭/屋崙",
                       "lv": "Oklenda",
                       "so": "Oakland",
                       "ca": "Oakland",
                       "pl": "Oakland",
                       "pt": "Oakland",
                       "an": "Oakland",
                       "ar": "أوكلاند (كاليفورنيا)",
                       "uk": "Окленд",
                       "mk": "Оукленд",
                       "be": "Окленд",
                       "en": "Oakland",
                       "fa": "اوکلند، کالیفرنیا",
                       "bm": "Oakland",
                       "ml": "ഓക്‌ലാന്റ്, കാലിഫോർണിയ",
                       "nl": "Oakland",
                       "de": "Oakland",
                       "az": "Oklend",
                       "es": "Oakland",
                       "nv": "Chéchʼiltah Hatsoh",
                       "el": "Όουκλαντ",
                       "ia": "Oakland",
                       "et": "Oakland",
                       "ru": "Окленд",
                       "cs": "Oakland",
                       "eo": "Oakland",
                       "ms": "Oakland",
                       "kw": "Oakland",
                       "ta": "ஓக்லண்ட், கலிபோர்னியா",
                       "fy": "Oakland",
                       "vo": "Oakland",
                       "yi": "אקלאנד, קאליפארניע",
                       "br": "Oakland",
                       "bg": "Оукланд",
                       "uz": "Oakland",
                       "da": "Oakland",
                       "hu": "Oakland",
                       "fi": "Oakland",
                       "tl": "Oakland",
                       "lt": "Oklandas",
                       "nn": "Oakland i California"
                   },
                   "lat": 37.8044557,
                   "lon": -122.271356,
                   "country": "US",
                   "state": "California"
               },
               {
                   "name": "Oakland",
                   "lat": 41.3107195,
                   "lon": -95.3966425,
                   "country": "US",
                   "state": "Iowa"
               },
               {
                   "name": "Oakland",
                   "lat": 37.0419887,
                   "lon": -86.2483177,
                   "country": "US",
                   "state": "Kentucky"
               },
               {
                   "name": "Oakland",
                   "lat": 40.4389972,
                   "lon": -79.9557454,
                   "country": "US",
                   "state": "Pennsylvania"
               },
               {
                   "name": "Oakland",
                   "lat": 38.5764418,
                   "lon": -90.3856733,
                   "country": "US",
                   "state": "Missouri"
               }
           ]
        """.data(using: .utf8)!
    
    let badLocationResponse: Data = """
            {
                "cod": "404",
                "message": "city not found"
            }
        """.data(using: .utf8)!
    
    let goodWeatherResponse: Data = """
        {
            "coord": {
                "lon": -122.2714,
                "lat": 37.8045
            },
            "weather": [
                {
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03d"
                }
            ],
            "base": "stations",
            "main": {
                "temp": 16.86,
                "feels_like": 16.61,
                "temp_min": 11.9,
                "temp_max": 26.66,
                "pressure": 1012,
                "humidity": 77
            },
            "visibility": 10000,
            "wind": {
                "speed": 8.23,
                "deg": 290,
                "gust": 14.4
            },
            "clouds": {
                "all": 40
            },
            "dt": 1684372648,
            "sys": {
                "type": 2,
                "id": 2041412,
                "country": "US",
                "sunrise": 1684328265,
                "sunset": 1684379605
            },
            "timezone": -25200,
            "id": 5378538,
            "name": "Oakland",
            "cod": 200
        }
    """.data(using: .utf8)!
    
    let badWeatherResponse: Data = """
        {
            "cod": "400",
            "message": "wrong latitude"
        }
    """.data(using: .utf8)!
}
