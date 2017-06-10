//
//  OrderingViewController.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 08.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import UIKit

class OrderingViewController: UITableViewController {

    private let totalTextTemplate = "Total: %d"
    private let totalLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 21))
   
    var presenter : OrderingPresenter! {
        didSet {
            presenter.view = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Text
        totalLabel.backgroundColor = .clear
        self.toolbarItems = [UIBarButtonItem(customView: totalLabel)]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        totalLabel.text = String(format: totalTextTemplate, 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productItemCell = tableView.dequeueReusableCell(withIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
        
        let productData = presenter.dataForRowAt(in: indexPath.row)
        productItemCell.name.text = productData.name
        productItemCell.price.text = productData.price
        productItemCell.unit.text = productData.unit
        productItemCell.quantity.text = productData.quantity
        productItemCell.addTapHandler = didAddTapped
        productItemCell.removeTapHandler = didRemoveTapped
        return productItemCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func didAddTapped(sender: UITableViewCell) {
        if let index = self.tableView.indexPath(for: sender)?.row {
            presenter.addTappedForRowAt(in: index)
        }
    }
    
    func didRemoveTapped(sender: UITableViewCell) {
        if let index = self.tableView.indexPath(for: sender)?.row {
            presenter.removeTappedForRowAt(in: index)
        }
    }
    
       
}

extension OrderingViewController : OrderingView {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
