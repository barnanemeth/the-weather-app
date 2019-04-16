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
import SVGKit

class WeatherDetailsViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
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
        self.weatherDescriptionLabel.text = weatherData.description.capitalized
        self.temperatureLabel.text = weatherData.temperature.asCelsiusDegree
        self.minimumTemperatureLabel.text = weatherData.minimumTemperature.asCelsiusDegree
        self.maximumTemperatureLabel.text = weatherData.maximumTemperature.asCelsiusDegree
        self.pressureLabel.text = weatherData.pressure.asPascal
        self.humidityLabel.text = weatherData.humidity.asPercent
    }

}
