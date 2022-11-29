//
//  CountryListViewModel.swift
//  MVVM With Combine
//
//  Created by Samuel Kebis on 29/11/2022.
//

import UIKit
import SwiftUI
import Combine

protocol CountryListViewModel {
    init(tableView: UITableView, networkManager: NetworkManager)
    func reloadTable()
    func fetchCountries()
}

final class DefaultCountryListViewModel: NSObject, UITableViewDelegate, UITableViewDataSource, CountryListViewModel {
    @State private var countries: [String] = []
    private let tableView: UITableView
    private let networkManager: NetworkManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(tableView: UITableView, networkManager: NetworkManager) {
        self.tableView = tableView
        self.networkManager = networkManager
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        $countries.publisher
            .sink(receiveValue: { [weak self] _ in
                self?.reloadTable()
            })
            .store(in: &cancellables)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country_cell") as! CountyCellView
        cell.titleLabel.text = countries[indexPath.row]
        return cell
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func fetchCountries() {
        networkManager
            .fetchCountries()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] countries in
                self?.countries = countries
            })
            .store(in: &cancellables)
    }
}
