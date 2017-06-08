//
//  OrderingSceneTests.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 08.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import XCTest
@testable import ShoppingBasket

class OrderingSceneTests: XCTestCase {
    
    private var orderingScene: OrderingScene?
    private let productCatalog = ProductCatalog(products: [Product(name: "Egg", price: 2.1, unit: "by dozen"),
                                                           Product(name:"Peas", price: 0.95, unit: "by bag")])
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        orderingScene = OrderingScene(productCatalog: productCatalog)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization() {
        let productItems = orderingScene?.productItems
        
        XCTAssertEqual(2, productItems?.count, "Expected 2 product items got \(String(describing: productItems?.count))")
        XCTAssertEqual(0, orderingScene?.total, "Expected a total of 0 got \(String(describing: orderingScene?.total))")
    }
    
    func testAddProductItem() {
        guard var productItems = orderingScene?.productItems else {
            XCTFail()
            return
        }
        orderingScene?.add(productItem: productItems[0])
        orderingScene?.add(productItem: productItems[0])
        
        productItems = (orderingScene?.productItems)!
        XCTAssertEqual(2, productItems[0].quantity, "Expected a quantity of 2 got \(productItems[0].quantity)")
    }
    
    func testRemoveProductItem() {
        guard var productItems = orderingScene?.productItems else {
            XCTFail()
            return
        }
        orderingScene?.add(productItem: productItems[0])
        orderingScene?.add(productItem: productItems[0])
        orderingScene?.remove(productItem: productItems[0])
        
        productItems = (orderingScene?.productItems)!
        XCTAssertEqual(1, productItems[0].quantity, "Expected a quantity of 1 got \(productItems[0].quantity)")
    }
    
    func testRemoveProductItemOnEmptyList() {
        guard var productItems = orderingScene?.productItems else {
            XCTFail()
            return
        }
        
        orderingScene?.remove(productItem: productItems[0])
        
        productItems = (orderingScene?.productItems)!
        XCTAssertEqual(0, productItems[0].quantity, "Expected a quantity of 0 got \(productItems[0].quantity)")
    }
    
    func testTotalAfterAdd() {
        guard var productItems = orderingScene?.productItems else {
            XCTFail()
            return
        }
        orderingScene?.add(productItem: productItems[0])
        orderingScene?.add(productItem: productItems[0])
        
        let expectedTotal = 2 * productItems[0].price
        XCTAssertEqual(expectedTotal, orderingScene?.total, "Expected total == \(expectedTotal) got \(String(describing: orderingScene?.total))")
        
    }
    
    
}
