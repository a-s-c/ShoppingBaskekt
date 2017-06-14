//
//  SwinjectStoryboard+Setup.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 10.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import UIKit
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        
        defaultContainer.register(ProductCatalog.self) {r in
            let products = [Product(name: "Peas", price: 0.95, unit: "by bag"),
                            Product(name: "Eggs", price: 2.1, unit: "by dozen"),
                            Product(name: "Milk", price: 1.3, unit: "per bottle"),
                            Product(name: "Beans", price: 0.73, unit: "per can")]
            return ProductCatalog(products: products)
        }
        
        defaultContainer.register(OrderingScene.self) {r in
            return OrderingScene(productCatalog: r.resolve(ProductCatalog.self)!)
        }.inObjectScope(.container)
        
        defaultContainer.register(OrderingPresenter.self) {r in
            return OrderingPresenter(orderingScene: r.resolve(OrderingScene.self)!)
        }
        
        defaultContainer.register(CurrencyService.self) {r in
            return CurrencyService()
        }
        
        defaultContainer.register(CurrencyPresenter.self) {r in
            return CurrencyPresenter(bill: r.resolve(OrderingScene.self)!, currencyService: r.resolve(CurrencyService.self)!)
        }
        
        defaultContainer.storyboardInitCompleted(OrderingViewController.self) {r, c in
            c.presenter = r.resolve(OrderingPresenter.self)!
        }
        
        defaultContainer.storyboardInitCompleted(CurrencyViewController.self) {r, c in
            c.presenter = r.resolve(CurrencyPresenter.self)!
        }
        
        
    }
}
