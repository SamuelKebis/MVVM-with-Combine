//
//  CountryListViewModel.swift
//  MVVM With Combine
//
//  Created by Samuel Kebis on 29/11/2022.
//

import UIKit

class CountryListViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    // TODO: Replace dummy data
    private var countries: [String] = ["Sweden", "Switzerland", "Slovakia"]
    private let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
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
}
