//
//  WeatherDetailsViewController.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 16..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import UIKit
import SkeletonView
import PromiseKit

class WeatherDetailsViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var minimumTemperatureLabel: UILabel!
    @IBOutlet private weak var maximumTemperatureLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    
    private let apiClient = ApiClient()
    var city: City?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.fetchWeatherData()
    }

    // MARK: - Private methods
    
    private func setupNavigationBar() {
        self.title = self.city?.name
    }
    
    private func fetchWeatherData() {
        guard let city = self.city else { return }
        self.view.showAnimatedGradientSkeleton()
        firstly(execute: {
            self.apiClient.getWeather(for: city)
        }).ensure({ [weak self] in
            self?.view.hideSkeleton()
        }).done({ [weak self] weather in
            guard let self = self else { return }
            self.setupView(for: weather)
        }).catch({ [weak self] error in
            print(error)
        })
    }
    
    private func setupView(for weatherData: Weather) {
        self.cityLabel.text = self.city?.name
        self.stateLabel.text = self.city?.state
        self.temperatureLabel.text = weatherData.temperature.description
        self.minimumTemperatureLabel.text = weatherData.minimumTemperature.description
        self.maximumTemperatureLabel.text = weatherData.maximumTemperature.description
        self.pressureLabel.text = weatherData.pressure.description
        self.humidityLabel.text = weatherData.humidity.description
    }

}
