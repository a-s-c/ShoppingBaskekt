//
//  BasketTests.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 08.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class BasketTests: XCTestCase {
    
    private var basket: Basket?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        basket = Basket()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTotalOfEmtpyBasket() {
        XCTAssertEqual(0, basket?.total, "Expected a total of 0.0 got \(String(describing: basket?.total))")
    }
    
    func testAddProduct() {
        let egg = Product(name: "Eggs", price: 2.10, unit: "per dozen")
        basket?.add(product: egg)
        
        XCTAssertEqual(1, basket?.count, "Expected a count of 1 got \(String(describing: basket?.count))")
    }
    
    func testMultipleProducts() {
        let peas = Product(name: "Peas", price: 0.95, unit: "per bag")
        let egg = Product(name: "Eggs", price: 2.10, unit: "per dozen")
        basket?.add(product: peas)
        basket?.add(product: egg)
        basket?.add(product: egg)
        
        XCTAssertEqual(3, basket?.count, "Expected a count of 3 got \(String(describing: basket?.count))")
    }
    
    func testRemoveProduct() {
        let egg = Product(name: "Eggs", price: 2.10, unit: "per dozen")
        basket?.add(product: egg)
        
        XCTAssertEqual(1, basket?.count, "Expected a count of 1 got \(String(describing: basket?.count))")
        
        basket?.remove(product: egg)

        XCTAssertEqual(0, basket?.count, "Expected a count of 0 got \(String(describing: basket?.count))")
    }
    
    func testRemoveNotIncludedProduct() {
        let peas = Product(name: "Peas", price: 0.95, unit: "per bag")
        let egg = Product(name: "Eggs", price: 2.10, unit: "per dozen")
   
        basket?.add(product: egg)
        
        XCTAssertEqual(1, basket?.count, "Expected a count of 1 got \(String(describing: basket?.count))")
        
        basket?.remove(product: peas)
        
        XCTAssertEqual(1, basket?.count, "Expected a count of 1 got \(String(describing: basket?.count))")
    }
    
    func testNumberOf() {
        let peas = Product(name: "Peas", price: 0.95, unit: "per bag")
        let egg = Product(name: "Eggs", price: 2.10, unit: "per dozen")
        basket?.add(product: peas)
        basket?.add(product: egg)
        basket?.add(product: egg)
        
        let numberOfEggs = basket?.numberOf(product: egg)
        let numberOfPeas = basket?.numberOf(product: peas)

        XCTAssertEqual(1, numberOfPeas, "Expected number of Peas == 1 got \(String(describing: numberOfPeas))")
        XCTAssertEqual(2, numberOfEggs, "Expected number of Eggs == 2 got \(String(describing: numberOfEggs))")
    }
    
    func testTotal() {
        let peas = Product(name: "Peas", price: 0.95, unit: "per bag")
        let egg = Product(name: "Eggs", price: 2.10, unit: "per dozen")
        basket?.add(product: peas)
        basket?.add(product: egg)
        basket?.add(product: egg)

        let expectedTotal = 2 * egg.price + peas.price
        
        XCTAssertEqual(expectedTotal, basket?.total, "Expected a total of \(expectedTotal) got \(String(describing: basket?.total))")
    }
    
}
