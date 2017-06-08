//
//  Basket.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 08.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import Foundation

class Basket: NSObject {

    private var goods = [Product]()
    
    func add(product: Product) {
        goods.append(product)
    }
    
    func remove(product: Product) {
        if let productIndex = goods.index(of: product) {
            goods.remove(at: productIndex)
        }
    }
    
    func numberOf(product: Product) -> Int {
        let products = goods.filter {
            return $0.name == product.name
        }
        return products.count
    }
    
    var total: Float {
        return goods.reduce(0) {subtotal, product in
            return subtotal + product.price
        }
    }
    
    var count: Int {
        return goods.count
    }
    
}
