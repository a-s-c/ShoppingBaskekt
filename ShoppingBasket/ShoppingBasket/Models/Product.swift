//
//  Product.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 08.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import Foundation

class Product: NSObject {

    let name: String
    let price: Float
    let unit: String
    
    init(name: String, price: Float, unit: String) {
        self.name = name
        self.price = price
        self.unit = unit
    }
}
