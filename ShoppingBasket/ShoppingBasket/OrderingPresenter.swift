//
//  OrderingPresenter.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 10.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import UIKit

protocol OrderingView: class {
    
}

class OrderingPresenter: NSObject {
    
    private let orderingScene: OrderingScene
    
    public weak var view: OrderingView?
    
    init(orderingScene: OrderingScene) {
        self.orderingScene = orderingScene
    }
}
