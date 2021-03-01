//
//  Weather.swift
//  weather
//
//  Created by Ibragim Akaev on 28/02/2021.
//

import Foundation

struct Weather: Decodable {
    let geoObject: GeoObject
    let fact: Fact
    let forecasts: [Forecasts]
}

struct GeoObject: Decodable {
    let locality: Locality
}

struct Locality: Decodable {
    let name: String
}

struct Forecasts: Decodable {
    let sunrise: String
    let sunset: String
}

struct Fact: Decodable {
    let temp: Int
    let condition: String
    let windSpeed: Double
    let feelsLike: Int
    
    var conditionRu: String {
        switch condition {
        case "clear":                    return "Ясно"
        case "partly-cloudy":            return "Малооблачно"
        case "cloudy":                   return "Облачно с прояснениями"
        case "overcast":                 return "Пасмурно"
        case "drizzle":                  return "Морось"
        case "light-rain":               return "Небольшой дождь"
        case "rain":                     return "Дождь"
        case "moderate-rain":            return "Умеренно сильный дождь"
        case "heavy-rain":               return "Сильный дождь"
        case "continuous-heavy-rain":    return "Длительный сильный дождь"
        case "showers":                  return "Ливень"
        case "wet-snow":                 return "Дождь со снегом"
        case "light-snow":               return "Небольшой снег"
        case "snow":                     return "Снег"
        case "snow-showers":             return "Снегопад"
        case "hail":                     return "Град"
        case "thunderstorm":             return "Гроза"
        case "thunderstorm-with-rain":   return "Дождь с грозой"
        case "thunderstorm-with-hail":   return "Гроза с градом"
        default:                         return "Загрузка"
            
        }
    }
}
