//
//  Weather.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 16..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    
    // MARK: - Properties
    
    let name: String
    let description: String
    let icon: String
    let temperature: Double
    let pressure: Double
    let humidity: Double
    let minimumTemperature: Double
    let maximumTemperature: Double
    
    // MARK: - Coding keys
    
    enum RootCodingKeys: String, CodingKey {
        case name
        case weatherContainer = "weather"
        case mainContainer = "main"
    }
    
    enum WeatherCodingKeys: String, CodingKey {
        case description, icon
    }
    
    enum MainCodingKeys: String, CodingKey {
        case pressure, humidity
        case temperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTempereture = "temp_max"
    }
    
    // MARK: - Helper structs
    
    private struct WeatherContainer: Codable {
        let description: String
        let icon: String
    }
    
    // MARK: - Initialization
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        self.name = try rootContainer.decode(String.self, forKey: .name)
        
        var weatherArrayContainer = try rootContainer.nestedUnkeyedContainer(forKey: .weatherContainer)
        let weatherContainer = try weatherArrayContainer.decode(WeatherContainer.self)
        self.description = weatherContainer.description
        self.icon = weatherContainer.icon
        
        
        let mainContainer = try rootContainer.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .mainContainer)
        self.temperature = try mainContainer.decode(Double.self, forKey: .temperature)
        self.pressure = try mainContainer.decode(Double.self, forKey: .pressure)
        self.humidity = try mainContainer.decode(Double.self, forKey: .humidity)
        self.minimumTemperature = try mainContainer.decode(Double.self, forKey: .minimumTemperature)
        self.maximumTemperature = try mainContainer.decode(Double.self, forKey: .maximumTempereture)
    }
}
