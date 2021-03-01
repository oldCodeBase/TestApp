//
//  NetworkManager.swift
//  weather
//
//  Created by Ibragim Akaev on 28/02/2021.
//

import CoreLocation

struct NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchWeather(location: CLLocationCoordinate2D, completed: @escaping (Weather) -> Void) {
        
        let baseUrl   = "https://api.weather.yandex.ru/v2/forecast?lat="
        let arguments = "\(location.latitude)&lon=\(location.longitude)&lang=ru_RU&limit=1&hours=false"
        
        guard let url = URL(string: baseUrl + arguments) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("f1ce440c-f002-4aaf-ba41-3d68273934f7", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, error, _) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weather = try decoder.decode(Weather.self, from: data)
                completed(weather)
            } catch {
                print("Error")
            }
        }
        task.resume()
    }
}
