//
//  OrderingScene.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 08.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import UIKit

struct ProductItem {
    private (set) var name: String
    private (set) var price: Float
    private (set) var unit: String
    private (set) var quantity: Int
}

protocol Billable {
    var total: Float {get}
}

class OrderingScene: NSObject, Billable {
    private let catalog: ProductCatalog
    private let basket: Basket
    
    init(productCatalog: ProductCatalog) {
        self.catalog = productCatalog
        self.basket = Basket()
    }
    
    var productItems: [ProductItem] {
        return catalog.products.map { (product) -> ProductItem in
            let quantity = basket.numberOf(product: product)
            return ProductItem(name: product.name, price: product.price, unit: product.unit, quantity: quantity)
        }
    }
    
    var total: Float {
        return basket.total
    }
    
    func add(productItem: ProductItem) {
       executeIfProductExists(productItem: productItem, action: self.basket.add)
    }
    
    func remove(productItem: ProductItem) {
       executeIfProductExists(productItem: productItem, action: self.basket.remove)
    }
    
    private func executeIfProductExists(productItem: ProductItem, action: (_ product: Product)->()) {
        if let product = catalog.products.first(where: {$0.name == productItem.name}) {
            action(product)
        }

    }
}
