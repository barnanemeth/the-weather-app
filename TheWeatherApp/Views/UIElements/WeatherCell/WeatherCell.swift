//
//  WeatherCell.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 15..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    // MARK: - Properties
    
    static let height: CGFloat = 78.0
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var currentWeatherImageView: UIImageView!
    
    var city: City? {
        didSet {
            guard let city = self.city else { return }
            self.cityLabel.text = city.name
            self.stateLabel.text = city.state
        }
    }
    
    // MARK: - Cell life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Private methods
    
    

}
