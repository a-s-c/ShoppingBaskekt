//
//  OrderingPresenter.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 10.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import UIKit

protocol OrderingView: class {
    func reloadData()
}

class OrderingPresenter: NSObject {
    
    struct ProductData {
        let name : String
        let price : String
        let unit : String
        let quantity: String
    }
    
    private let orderingScene: OrderingScene
    
    weak var view: OrderingView?
    
    var total: String {
        return String(format: "$: %.2f", orderingScene.total)
    }
    
    init(orderingScene: OrderingScene) {
        self.orderingScene = orderingScene
    }
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfRows(in section: Int) -> Int {
        return orderingScene.productItems.count
    }
    
    public func dataForRowAt(in row: Int) -> OrderingPresenter.ProductData {
        let product = orderingScene.productItems[row]
        let price = String(format: "$ %.2f", product.price)
        let quantity = String(format: "%d", product.quantity)
        return ProductData(name: product.name, price: price, unit: product.unit, quantity: quantity)
    }
    
    public func addTappedForRowAt(in row: Int) {
        let product = orderingScene.productItems[row]
        orderingScene.add(productItem: product)
        view?.reloadData()
    }
    
    public func removeTappedForRowAt(in row: Int) {
        let product = orderingScene.productItems[row]
        orderingScene.remove(productItem: product)
        view?.reloadData()
    }
}
