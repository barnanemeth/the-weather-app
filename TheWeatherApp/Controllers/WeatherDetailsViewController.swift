//
//  WeatherDetailsViewController.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 16..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import UIKit
import SkeletonView

class WeatherDetailsViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var minimumTemperatureLabel: UILabel!
    @IBOutlet private weak var maximumTemperatureLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    
    var city: City?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.view.showAnimatedGradientSkeleton()
    }

    // MARK: - Private methods
    
    private func setupNavigationBar() {
        self.title = self.city?.name
    }

}
