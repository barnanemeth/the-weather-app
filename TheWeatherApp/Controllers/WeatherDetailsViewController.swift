//
//  WeatherDetailsViewController.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 16..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    // MARK: - Properties
    
    var city: City?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
    }

    // MARK: - Private methods
    
    private func setupNavigationBar() {
        self.title = self.city?.name
    }

}
