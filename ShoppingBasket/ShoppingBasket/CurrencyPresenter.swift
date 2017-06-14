//
//  CurrencyPresenter.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 14.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import Foundation

protocol CurrencyView: class {
    func reloadData()
}

class CurrencyPresenter: NSObject {
    
    struct CurrencyData {
        let name: String
        let isSelected: Bool
    }
    private let defaultCurrency = "USD"
    private var currencies: [CurrencyService.CurrencyItem] = []
    private var selectedCurrency: String
   
    private let bill: Billable
    private let currencyService: CurrencyService
    
    
    weak var view: CurrencyView?
    
    init(bill: Billable, currencyService: CurrencyService) {
        self.bill = bill
        self.currencyService = currencyService
        self.selectedCurrency = defaultCurrency
    }
    
    func viewDidLoad() {
        currencyService.allCurrencies(completion: {(currencyItems, error) in
            guard error == nil else {
                // could not load currencies
                return
            }
            self.currencies.removeAll()
            self.currencies += currencyItems!
            self.currencies = self.currencies.sorted(by: { $0.name < $1.name })
            self.view?.reloadData()
        })
    }
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfRows(in section: Int) -> Int {
       return currencies.count
    }
    
    public func dataForRowAt(in row: Int) -> CurrencyPresenter.CurrencyData {
        let currencyItem = currencies[row]
        
        return CurrencyData(name: currencyItem.name, isSelected: currencyItem.key == selectedCurrency)
    }
    
    var total: String {
        return String(format: "%.2f (%@)", selectedCurrency, bill.total)
    }
    
    
}
