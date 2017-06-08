//
//  ProductCatalogTests.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 08.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class ProductCatalogTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyProductCatalog() {
        let productCatalog = ProductCatalog(products: [])
        XCTAssertEqual(0, productCatalog.products.count, "Expected empty set of products got \(productCatalog.products.count)")
    }
    
    func testProductCatalogWithMultipleProducts() {
        let peas = Product(name: "Peas", price: 0.95, unit: "per bag")
        let eggs = Product(name: "Eggs", price: 2.10, unit: "by dozen")
        
        let productCatalog = ProductCatalog(products: [peas, eggs])
        
        XCTAssertEqual(2, productCatalog.products.count, "Expected 2 products got \(productCatalog.products.count)")
        
        let products = Array<Product>(productCatalog.products)
        XCTAssertTrue(products.contains(peas), "Expected peas in products")
        XCTAssertTrue(products.contains(eggs), "Expected eggs in products")
        
    }
    
     func testProductCatalogWithMultiplDuplicates() {
        let peas = Product(name: "Peas", price: 0.95, unit: "per bag")
        
        let productCatalog = ProductCatalog(products: [peas, peas])
        
         XCTAssertEqual(1, productCatalog.products.count, "Expected 1 product got \(productCatalog.products.count)")
        let products = Array<Product>(productCatalog.products)
        XCTAssertTrue(products.contains(peas), "Expected peas in products")
    }
}
