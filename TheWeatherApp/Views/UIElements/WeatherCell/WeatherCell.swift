//
//  WeatherCell.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 15..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher

final class WeatherCell: UITableViewCell {

    // MARK: - Properties
    
    static let height: CGFloat = 78.0
    
    private let apiClient = ApiClient()
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var currentWeatherImageView: UIImageView!
    @IBOutlet private weak var currentWeatherActivityIndicator: UIActivityIndicatorView!
    
    var city: City? {
        didSet {
            guard let city = self.city else { return }
            self.cityLabel.text = city.name
            self.stateLabel.text = city.state
            self.fetchWeatherData()
        }
    }
    
    private var isLoading: Bool = false {
        didSet {
            self.currentWeatherActivityIndicator.isHidden = !self.isLoading
            if self.isLoading {
                self.currentWeatherActivityIndicator.startAnimating()
            } else {
                self.currentWeatherActivityIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: - Cell life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isLoading = false
    }
    
    // MARK: - Private methods
    
    private func fetchWeatherData() {
        guard let city = self.city else {
            self.isLoading = false
            return
        }
        self.isLoading = true
        self.apiClient.getWeather(for: city)
        .ensure({ [weak self] in
            self?.isLoading = false
        })
        .done({ [weak self] weather in
            self?.currentWeatherImageView.kf.setImage(with: URL(string: "http://openweathermap.org/img/w/\(weather.icon).png"))
        }).cauterize()
    }

}
