//
//  CurrencyViewController.swift
//  ShoppingBasket
//
//  Created by Alexander Schacht on 10.06.17.
//  Copyright © 2017 Alexander Schacht. All rights reserved.
//

import UIKit

class CurrencyViewController: UITableViewController {

    let totalTextTemplate = "Total: %@"
    let totalLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 21))
    
    var presenter : CurrencyPresenter! {
        didSet {
            presenter.view = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        totalLabel.backgroundColor = .clear
        self.toolbarItems = [UIBarButtonItem(customView: totalLabel)]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        totalLabel.text = String(format: totalTextTemplate, presenter.total)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRows(in: 0)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyItemCell", for: indexPath)
        let currencyData = self.presenter.dataForRowAt(in: indexPath.row)
        cell.textLabel?.text = currencyData.name
        cell.accessoryType = .none
        if (currencyData.isSelected) {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath){
//        for indexPath in self.tableView.indexPathsForVisibleRows ?? [] {
//            let cell = tableView.cellForRow(at: indexPath)
//            cell?.accessoryType = .none
//        }
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.accessoryType = .checkmark
    }

}

extension CurrencyViewController : CurrencyView {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
           // self.totalLabel.text = String(format: self.totalTextTemplate, self.presenter.total)
        }
    }
}
