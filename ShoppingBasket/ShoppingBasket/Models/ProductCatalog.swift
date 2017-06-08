//
//  ProductCatalog.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 08.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import Foundation

class ProductCatalog: NSObject {
    
    let products: Set<Product>
    
    init(products: [Product]) {
        self.products = Set<Product>(products)
    }
}
