//
//  Double+Format.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 16..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import Foundation

extension Double {
    
    var asCelsiusDegree: String {
        return String(format: "%0.f℃", self)
    }
    
    var asPercent: String {
        return "\(String(format: "%0.f", self))%"
    }
    
    var asPascal: String {
        return String(format: "%0.fhPa", self)
    }
}
