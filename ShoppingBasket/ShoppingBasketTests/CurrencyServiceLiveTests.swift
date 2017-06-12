//
//  CurrencyServiceTests.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 11.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class CurrencyServiceLiveTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
       
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAllCurrencies() {
        let currencyService = CurrencyService()
        let allCurrenciesExpectation = expectation(description: "Wait for allCurrencies.")
         currencyService.allCurrencies { (currencies, error) in
            allCurrenciesExpectation.fulfill()
        }
        
         waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testExchangeRate() {
        let currencyService = CurrencyService()
        let exchangeRateExpectation = expectation(description: "Wait for exchangeRate.")
        currencyService.exchangeRate(destination: "EUR", completion: {(exchangeRate, error) in
            exchangeRateExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    
}
