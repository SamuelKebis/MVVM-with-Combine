//
//  CountryListViewController.swift
//  MVVM With Combine
//
//  Created by Samuel Kebis on 29/11/2022.
//

import UIKit

class CountryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var countryDelegate: CountryListViewModel = DefaultCountryListViewModel(
        tableView: tableView,
        networkManager: DefaultNetworkManager()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryDelegate.reloadTable()
        countryDelegate.fetchCountries()
    }
}
