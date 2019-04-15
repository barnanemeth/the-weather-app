//
//  WeatherListViewController.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 15..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import UIKit

class WeatherListViewController: UITableViewController {

    // MARK: - Properties
    
    private var cities = [City]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        self.setupTableView()
        self.loadCities()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
    }
    
    private func loadCities() {
        guard let citiesResourcePath = Bundle.main.url(forResource: "Cities", withExtension: "json") else { return }
        guard let citiesData = try? Data(contentsOf: citiesResourcePath) else { return }
        do {
            self.cities = try JSONDecoder.init().decode([City].self, from: citiesData)
        } catch {
            fatalError("Cities.json resource is malformed")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
            fatalError("WeatherCell not found")
        }
        cell.city = self.cities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return WeatherCell.height
    }


}
