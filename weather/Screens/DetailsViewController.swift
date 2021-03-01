//
//  DetailsViewController.swift
//  weather
//
//  Created by Ibragim Akaev on 28/02/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var weather: Weather!
    
    private let cityNameLabel       = TitleLabel(textAlignment: .center, fontSize: 44)
    private let tempLabel           = TitleLabel(textAlignment: .center, fontSize: 100)
    private let conditionLabel      = SecondaryLabel(textAlignment: .center)
    private let sunriseLabel        = SecondaryLabel(textAlignment: .right)
    private let sunriseInfoLabel    = TitleLabel(textAlignment: .right, fontSize: 30)
    private let sunsetLabel         = SecondaryLabel(textAlignment: .right)
    private let sunsetInfoLabel     = TitleLabel(textAlignment: .right, fontSize: 30)
    private let windLabel           = SecondaryLabel(textAlignment: .right)
    private let windInfoLabel       = TitleLabel(textAlignment: .right, fontSize: 30)
    private let feelsLikeLabel      = SecondaryLabel(textAlignment: .right)
    private let feelsLikeInfoLabel  = TitleLabel(textAlignment: .right, fontSize: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateWeatherDataFor(city: weather)
        view.backgroundColor = .systemBackground
    }
    
    private func updateUI() {
        view.addSubviews(cityNameLabel, tempLabel, conditionLabel, sunriseLabel, sunriseInfoLabel,
                         sunsetLabel, sunsetInfoLabel, windLabel, windInfoLabel, feelsLikeLabel, feelsLikeInfoLabel)
        
        sunsetLabel.text    = "ЗАКАТ"
        sunriseLabel.text   = "ВОСХОД"
        windLabel.text      = "СКОРОСТЬ ВЕТРА"
        feelsLikeLabel.text = "ОЩУЩАЕМАЯ"
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            conditionLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 4),
            conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tempLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 8),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),

            sunriseLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 30),
            sunriseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            sunriseInfoLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 4),
            sunriseInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            sunsetLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 30),
            sunsetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            sunsetInfoLabel.topAnchor.constraint(equalTo: sunsetLabel.bottomAnchor, constant: 4),
            sunsetInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            windLabel.topAnchor.constraint(equalTo: sunriseInfoLabel.bottomAnchor, constant: 16),
            windLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            windInfoLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 4),
            windInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            feelsLikeLabel.topAnchor.constraint(equalTo: sunsetInfoLabel.bottomAnchor, constant: 16),
            feelsLikeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            feelsLikeInfoLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 4),
            feelsLikeInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func updateWeatherDataFor(city: Weather) {
        
        cityNameLabel.text      = city.geoObject.locality.name
        tempLabel.text          = "\(city.fact.temp)°"
        conditionLabel.text     = city.fact.conditionRu
        sunsetInfoLabel.text    = city.forecasts.first?.sunset
        sunriseInfoLabel.text   = city.forecasts.first?.sunrise
        windInfoLabel.text      = "\(city.fact.windSpeed) М/С"
        feelsLikeInfoLabel.text = "\(city.fact.feelsLike) °C"
    }
}
