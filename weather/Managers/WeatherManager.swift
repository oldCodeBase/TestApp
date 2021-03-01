//
//  WeatherManager.swift
//  weather
//
//  Created by Ibragim Akaev on 01/03/2021.
//

import CoreLocation

struct WeatherManager {
    
    static let shared = WeatherManager()
    private init() {}
    
    func getCityWeather(cities: [String], complete: @escaping ([Weather]) -> Void) {
        var weatherArray = [Weather]()
        for city in cities {
            GeoService.shared.getLocation(for: city) { (location, error) in
                guard let location = location, error == nil else { return }
                NetworkManager.shared.fetchWeather(location: location) { weather in
                    weatherArray.append(weather)
                    complete(weatherArray)
                }
            }
        }
    }
}
