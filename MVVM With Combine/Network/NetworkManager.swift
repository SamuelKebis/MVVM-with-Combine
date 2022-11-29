//
//  NetworkManager.swift
//  MVVM With Combine
//
//  Created by Samuel Kebis on 29/11/2022.
//

import Foundation
import Combine

protocol NetworkManager {
    func fetchCountries() -> AnyPublisher<[String], Error>
}

class DefaultNetworkManager: NetworkManager {
    func fetchCountries<T: Decodable>() -> AnyPublisher<T, Error> {
        
        let urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: "") else {
            fatalError("Could not create url")
        }
        
        return urlSession.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
