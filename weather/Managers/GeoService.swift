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
    
    func getLocation(for city: String, complete: @escaping (_ location: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            complete(placemark?.first?.location?.coordinate, error)
        }
    }
}
