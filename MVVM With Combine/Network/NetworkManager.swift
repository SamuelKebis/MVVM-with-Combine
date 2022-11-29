//
//  NetworkManager.swift
//  MVVM With Combine
//
//  Created by Samuel Kebis on 29/11/2022.
//

import Foundation

protocol NetworkManager {
    func fetchCountries()
}

class DefaultNetworkManager: NetworkManager {
    func fetchCountries() {
        // TODO: implementation
    }
}
