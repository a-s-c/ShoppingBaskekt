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
    
    private let bill: Billable
    private let currencyService: CurrencyService
    private var currencies: [CurrencyService.CurrencyItem] = []
    private var selectedCurrency: CurrencyService.CurrencyItem?
    
    weak var view: CurrencyView?
    
    init(bill: Billable, currencyService: CurrencyService) {
        self.bill = bill
        self.currencyService = currencyService
    }
    
    func viewDidLoad() {
        currencyService.allCurrencies(completion: {(currencyItems, error) in
            guard error == nil else {
                // could not load currencies
                return
            }
            self.currencies.removeAll()
            self.currencies += currencyItems!
            self.selectedCurrency = self.defaultCurrency
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
        let currencyItem = currencies[0]
        let isSelected = selectedCurrency != nil && currencyItem.key == selectedCurrency!.key
        
        return CurrencyData(name: currencyItem.name, isSelected: isSelected)
    }
    
    private var defaultCurrency: CurrencyService.CurrencyItem {
        return currencies.first {$0.key == "USD"}!
    }
    
}
