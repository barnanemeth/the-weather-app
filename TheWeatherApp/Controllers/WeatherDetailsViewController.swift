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
    
    @IBOutlet private weak var weatherImageView: UIImageView!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        }).done({ [weak self] weather in
            guard let self = self else { return }
            self.view.hideSkeleton()
            self.setupView(for: weather)
        }).catch({ [weak self] error in
            guard let networkingError = error as? NetworkingError, case .serviceError(let status) = networkingError else {
                self?.showAlert(for: error)
                return
            }
            if status == .notFound {
                self?.showAlert(title: NSLocalizedString("Sorry", comment: ""), message: NSLocalizedString("City is not found", comment: ""), defaultButtonHandler: {
                    self?.navigationController?.popViewController(animated: true)
                })
                return
            }
            self?.showGenericAlert()
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
        
        if let imageName = self.getImageName(for: weatherData.weatherID, and: weatherData.description) {
            guard let image = SVGKImage(named: imageName) else { return }
            image.size = self.weatherImageView.frame.size
            self.weatherImageView.image = image.uiImage
        }
    }
    
    private func getImageName(for weatherID: Int, and description: String) -> String? {
        guard let weathersResourcePath = Bundle.main.url(forResource: "WeatherIcons", withExtension: "json") else { return nil }
        guard let weathersData = try? Data(contentsOf: weathersResourcePath) else { return nil }
        do {
            let weatherDictionary = try JSONDecoder.init().decode([String: [String: String]].self, from: weathersData)
            guard let innerDictionary = weatherDictionary[weatherID.description] else { return nil }
            guard let iconName = innerDictionary["icon"] else { return nil }
            
            if !(weatherID > 699 && weatherID < 800) && !(weatherID > 899 && weatherID < 1000) {
                return "wi-day-\(iconName)"
            }
            return "wi-\(iconName)"
        } catch {
            return nil
        }
    }

}
