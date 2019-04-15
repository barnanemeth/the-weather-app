//
//  Errors.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 15..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case serviceError(HTTPStatusCode)
    case dataError(Error)
}
