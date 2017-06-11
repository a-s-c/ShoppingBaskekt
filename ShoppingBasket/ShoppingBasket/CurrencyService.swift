//
//  CurrencyService.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 11.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import UIKit

class CurrencyService: NSObject {
    
    typealias ExchangeRateHandler = ((Float?, NSError?) -> ())
    typealias AllCurrenciesHandler = (([CurrencyItem]?, NSError?) -> ())
    private let endpoint = "http://apilayer.net/api/%@?%@"
    private let accessKey = "access_key=a836973956f464d8548d51d0c3194571"
    struct CurrencyItem {
        let key: String
        let name: String
    }
    
    func allCurrencies(completion: @escaping AllCurrenciesHandler) {
        guard let url = listEndpoint else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print(error!)
                completion(nil, error as! NSError)
                return
            }
            
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                completion(nil, nil)
                return
            }
            guard let response = try? JSONSerialization.jsonObject(with: responseData, options: [])
                as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    completion(nil, nil)
                    return
            }
            guard let currencyDict = response?["currencies"] as? [String: String] else {
                print("error trying to convert data to JSON")
                completion(nil, nil)
                return
            }
            
            let currencies = currencyDict.map({ (key: String, value: String) in
                return CurrencyItem(key: key, name: value)
            })
            
            completion(currencies, nil)
        }
        task.resume()
    }
    
    func exchangeRate(destination: String, completion: ExchangeRateHandler)  {
        
    }

    var listEndpoint: URL? {
        return URL(string: String(format: endpoint, "list", accessKey))
    }
}
