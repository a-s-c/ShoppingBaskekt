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
    private var localCurrency: Float
   
    private let bill: Billable
    private let currencyService: CurrencyService
    
    
    weak var view: CurrencyView?
    
    init(bill: Billable, currencyService: CurrencyService) {
        self.bill = bill
        self.localCurrency = self.bill.total
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
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
       return currencies.count
    }
    
    func dataForRowAt(in row: Int) -> CurrencyPresenter.CurrencyData {
        let currencyItem = currencies[row]
        
        return CurrencyData(name: currencyItem.name, isSelected: currencyItem.key == selectedCurrency)
    }
    
    func didSelectRowAt(in row: Int) {
        let currencyItem = currencies[row]
        self.selectedCurrency = currencyItem.key
        self.exchange(destination: currencyItem.key)
        view?.reloadData()
    }
    
    var total: String {
        return String(format: "%.2f (%@)", selectedCurrency, self.localCurrency)
    }
    
    private func exchange(destination: String) {
        self.currencyService.exchangeRate(destination: destination) { (rate, error) in
            guard error == nil else {
                // could not load exchange rate
                return
            }
            self.localCurrency = self.bill.total * rate!
            self.view?.reloadData()
        }
    }
    
}
