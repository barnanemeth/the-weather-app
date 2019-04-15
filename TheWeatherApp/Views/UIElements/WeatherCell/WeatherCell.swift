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
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var currentWeatherImageView: UIImageView!
    
    // MARK: - Cell life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Private methods
    
    

}
