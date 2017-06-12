//
//  CurrencyServiceTests.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 12.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import ShoppingBasket

class CurrencyServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllCurrencies() {
        stub(condition: isHost("apilayer.net")) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("currencylayer-list-response.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        let currencyService = CurrencyService()
        let allCurrenciesExpectation = expectation(description: "Wait for allCurrencies.")
        currencyService.allCurrencies { (currencies, error) in
            XCTAssertNil(error)
            XCTAssertEqual(169, currencies?.count)
            allCurrenciesExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testAllCurrenciesResponseWithError() {
        stub(condition: isHost("apilayer.net")) { _ in
            return OHHTTPStubsResponse(data: Data(), statusCode: 404, headers: nil)
        }
        
        let currencyService = CurrencyService()
        let allCurrenciesExpectation = expectation(description: "Wait for allCurrencies.")
        currencyService.allCurrencies { (currencies, error) in
            XCTAssertNotNil(error)
            allCurrenciesExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testAllCurrenciesResponseNoDictionary() {
        stub(condition: isHost("apilayer.net")) { _ in
            let stubData = "{}".data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
        }
        let currencyService = CurrencyService()
        let allCurrenciesExpectation = expectation(description: "Wait for allCurrencies.")
        currencyService.allCurrencies { (currencies, error) in
            XCTAssertNotNil(error)
            allCurrenciesExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testExchangeRate() {
        stub(condition: isHost("apilayer.net")) { _ in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("currencylayer-live-response.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        let currencyService = CurrencyService()
        let exchangeRateExpectation = expectation(description: "Wait for exchangeRate.")
        currencyService.exchangeRate(destination: "EUR", completion: { (rate, error) in
            XCTAssertNil(error)
            XCTAssertEqual(0.8921, rate)
            exchangeRateExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testExchangeRateResponseWithError() {
        stub(condition: isHost("apilayer.net")) { _ in
            return OHHTTPStubsResponse(data: Data(), statusCode: 404, headers: nil)
        }
        
        let currencyService = CurrencyService()
        let exchangeRateExpectation = expectation(description: "Wait for exchangeRate.")
        currencyService.exchangeRate(destination: "EUR", completion: { (rate, error) in
            XCTAssertNotNil(error)
            exchangeRateExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testExchangeRateResponseNoDictionary() {
        stub(condition: isHost("apilayer.net")) { _ in
            let stubData = "{}".data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
        }
        let currencyService = CurrencyService()
        let exchangeRateExpectation = expectation(description: "Wait for exchangeRate.")
        currencyService.exchangeRate(destination: "EUR", completion: { (rate, error) in
            XCTAssertNotNil(error)
            exchangeRateExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testExchangeRateResponseInvalidDestination() {
        stub(condition: isHost("apilayer.net")) { _ in
            let stubData = "{\"quotes\": {}}".data(using: String.Encoding.utf8)
            return OHHTTPStubsResponse(data: stubData!, statusCode:200, headers:nil)
        }
        let currencyService = CurrencyService()
        let exchangeRateExpectation = expectation(description: "Wait for exchangeRate.")
        currencyService.exchangeRate(destination: "EUR", completion: { (rate, error) in
            XCTAssertNotNil(error)
            exchangeRateExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
}
