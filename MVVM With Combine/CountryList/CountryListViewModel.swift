//
//  CountryListViewModel.swift
//  MVVM With Combine
//
//  Created by Samuel Kebis on 29/11/2022.
//

import UIKit

protocol CountryListViewModel {
    init(tableView: UITableView, networkManager: NetworkManager)
    func reloadData()
    func fetchCountries()
}

final class DefaultCountryListViewModel: NSObject, UITableViewDelegate, UITableViewDataSource, CountryListViewModel {
    private var countries: [String] = []
    private let tableView: UITableView
    private let networkManager: NetworkManager
    
    init(tableView: UITableView, networkManager: NetworkManager) {
        self.tableView = tableView
        self.networkManager = networkManager
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country_cell") as! CountyCellView
        cell.titleLabel.text = countries[indexPath.row]
        return cell
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func fetchCountries() {
        networkManager.fetchCountries()
        // TODO: Reload table view when data are fetched.
    }
}
