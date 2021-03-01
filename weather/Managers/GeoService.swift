//
//  GeoService.swift
//  weather
//
//  Created by Ibragim Akaev on 01/03/2021.
//

import CoreLocation

struct GeoService {
    
    static let shared = GeoService()
    private init() {}
    
    func getLocation(for cityName: String, complete: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(cityName) { (placemark, error) in
            complete(placemark?.first?.location?.coordinate, error)
        }
    }
}
