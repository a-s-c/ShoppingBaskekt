//
//  CurrencyService.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 11.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import Foundation
import Alamofire

class CurrencyService: NSObject {

    enum CurrencyServiceError: Error {
        case invalidJSON
        case invalidDestination
    }

    typealias ExchangeRateHandler = ((Float?, Error?) -> ())
    typealias AllCurrenciesHandler = (([CurrencyItem]?, Error?) -> ())
    private let endpoint = "http://apilayer.net/api/%@?%@"
    private let accessKey = "access_key=a836973956f464d8548d51d0c3194571"
   
    struct CurrencyItem {
        let key: String
        let name: String
    }
    
    func allCurrencies(completion: @escaping AllCurrenciesHandler) {
        
        Alamofire.request(listEndpoint)
            .responseJSON { response in
                    guard response.result.error == nil else {
                    completion(nil, response.result.error)
                    return
                }
                
                guard let json = response.result.value as? [String: Any], let currencyDict = json["currencies"] as? [String: String] else {
                    completion(nil, CurrencyServiceError.invalidJSON)
                    return
                }
                
                let currencies = currencyDict.map({ (key: String, value: String) in
                    return CurrencyItem(key: key, name: value)
                })
                
                completion(currencies, nil)
        }
    }
    
    func exchangeRate(destination: String, completion: @escaping ExchangeRateHandler)  {
        let endpoint = String(format: "%@&currencies=%@", liveEndpoint, destination)
        Alamofire.request(endpoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    completion(nil, response.result.error)
                    return
                }
                
                guard let json = response.result.value as? [String: Any], let quotesDict = json["quotes"] as? [String: Float] else {
                    completion(nil, CurrencyServiceError.invalidJSON)
                    return
                }
                
                guard let rate = quotesDict[String(format: "USD%@", destination)] else {
                    completion(nil, CurrencyServiceError.invalidDestination)
                    return
                }
                completion(rate, nil)
        }
    }

    var listEndpoint: String {
        return  String(format: endpoint, "list", accessKey)
    }
    
    var liveEndpoint: String {
        return  String(format: endpoint, "live", accessKey)
    }
    
}
