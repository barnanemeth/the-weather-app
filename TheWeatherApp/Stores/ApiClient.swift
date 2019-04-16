//
//  ApiClient.swift
//  TheWeatherApp
//
//  Created by Németh Barna on 2019. 04. 15..
//  Copyright © 2019. Barna Nemeth. All rights reserved.
//

import Alamofire
import PromiseKit

final class ApiClient {
    
    // MARK: - Properties
    
    private let serviceAddress = Bundle.main.object(forInfoDictionaryKey: "ServiceAddress") as! String
    private let appID = Bundle.main.object(forInfoDictionaryKey: "OpenweathermapAppID") as! String
    private let language = Locale.preferredLanguages.first!
    private let decoder: JSONDecoder
    
    // MARK: - Initialization
    
    init() {
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .useDefaultKeys
    }
    
    // MARK: - Private methods
    
    private func decode<T: Decodable>(from data: Data, resolver: Resolver<T>) {
        do {
            try resolver.fulfill(self.decoder.decode(T.self, from: data))
        } catch {
            resolver.reject(NetworkingError.dataError(error))
        }
    }
    
    private func getNetworkingError(forResponse response: PMKAlamofireDataResponse) -> NetworkingError {
        return NetworkingError.serviceError(HTTPStatusCode(rawValue: response.response?.statusCode ?? -1) ?? .unknown)
    }
    
    private func buildPromise<T: Decodable>(url: URLConvertible, parameters: Parameters, successStatus: HTTPStatusCode) -> Promise<T> {
        return Promise(resolver: {resolver in
            firstly(execute: {
                Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseData()
            }).done({ data, response in
                guard response.response?.statusCode == successStatus.rawValue else {
                    resolver.reject(self.getNetworkingError(forResponse: response))
                    return
                }
                self.decode(from: data, resolver: resolver)
            }).catch({error in
                resolver.reject(error)
            })
        })
    }
    
    // MARK: - Public methods
    
    public func getWeather(for city: City) -> Promise<Weather> {
        let url = "\(self.serviceAddress)/weather"
        let parameters: Parameters = ["q": city.name, "appid": self.appID, "units": "metric", "lang": self.language]
        return self.buildPromise(url: url, parameters: parameters, successStatus: .OK)
    }
    
    
}
