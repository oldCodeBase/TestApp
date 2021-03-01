//
//  CityCell.swift
//  weather
//
//  Created by Ibragim Akaev on 28/02/2021.
//

import UIKit

class CityCell: UITableViewCell {
    
    static let reuseID  = "CityCell"
    let cityNameLabel   = TitleLabel(textAlignment: .left, fontSize: 24)
    let tempLabel       = TitleLabel(textAlignment: .right, fontSize: 34)
    let conditionLabel  = SecondaryLabel(textAlignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(city: Weather) {
        cityNameLabel.text  = city.geoObject.locality.name
        tempLabel.text      = "\(city.fact.temp) °C"
        conditionLabel.text = city.fact.conditionRu
    }
    
    private func configure() {
        addSubviews(cityNameLabel, conditionLabel, tempLabel)
        
        let margin: CGFloat  = 20
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            cityNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin),
            cityNameLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: padding),
            
            conditionLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 4),
            conditionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin),
            conditionLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: padding),
            conditionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            
            tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin),
            tempLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tempLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
