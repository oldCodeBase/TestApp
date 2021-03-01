//
//  MainViewController.swift
//  weather
//
//  Created by Ibragim Akaev on 28/02/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView         = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var cities: [Weather]           = []
    private var fetchedCities: [Weather]    = []
    private var cityNames                   = ["Moscow", "New-York", "London", "Paris", "Berlin",
                                               "Rim", "Oslo", "Grozny", "Madrid", "Amsterdam"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
        configureSearchController()
        uploadData()
    }
    
    private func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Погода"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.reuseID)
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeExcessCells()
    }
    
    private func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Поиск города"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    private func showActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func uploadData() {
        showActivityIndicator()
        WeatherManager.shared.getCityWeather(cities: cityNames) { [weak self] weather in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.removeFromSuperview()
                self.fetchedCities = weather
                self.cities = self.fetchedCities
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseID) as! CityCell
        let city = cities[indexPath.row]
        cell.set(city: city)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        let detailsViewController = DetailsViewController()
        detailsViewController.weather = city
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            cities = fetchedCities
            tableView.reloadData()
            return
        }
        
        cities = cities.filter { $0.geoObject.locality.name.lowercased().contains(text.lowercased()) }
        tableView.reloadData()
    }
}

