//
//  ProductTests.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 08.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class ProductTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProductName() {
        let name = "Eggs"
        let product = Product(name: name, price: 0.0, unit: "")
        XCTAssertEqual(name, product.name, "Expected name == \(name) got \(product.name)")
    }

    func testProductPrice() {
        let price: Float = 1.23
        let product = Product(name: "", price: price, unit: "")
        XCTAssertEqual(price, product.price, "Expected price == \(price) got \(product.price)")
    }
    
    func testProductUnit() {
        let unit = "by dozen"
        let product = Product(name: "", price: 0.0, unit: unit)
        XCTAssertEqual(unit, product.unit, "Expected unit == \(unit) got \(product.unit)")
    }
}
