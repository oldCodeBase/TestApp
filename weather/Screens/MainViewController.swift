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
    
    private var isFiltering       = false
    private var cities            = [Weather]()
    private var filteredСities    = [Weather]()
    private var cityNames         = ["Moscow", "New-York", "London", "Paris", "Berlin",
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
    
    private func dismissActivityIndicator() {
        self.activityIndicator.removeFromSuperview()
    }
    
    private func uploadData() {
        showActivityIndicator()
        WeatherManager.shared.getCityWeather(cities: cityNames) { [weak self] weather in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dismissActivityIndicator()
                self.cities = weather
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource methods
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredСities.count : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseID) as! CityCell
        let city = isFiltering ? filteredСities[indexPath.row] : cities[indexPath.row]
        cell.set(city: city)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = isFiltering ? filteredСities[indexPath.row] : cities[indexPath.row]
        let detailsViewController = DetailsViewController()
        detailsViewController.weather = city
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredСities.removeAll()
            isFiltering = false
            tableView.reloadData()
            return
        }
        
        isFiltering = true
        filteredСities = cities.filter { $0.geoObject.locality.name.lowercased().contains(filter.lowercased()) }
        tableView.reloadData()
    }
}

