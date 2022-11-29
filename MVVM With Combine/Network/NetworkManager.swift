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
        guard let url = URL(string: "https://api.json-generator.com/templates/GlOxEqjDIq8M/data") else {
            fatalError("Could not create url")
        }
        let personalToken = "Bearer 5x7rw1qzuivd5udglbk2rhf7y423dqctwq2913h6"
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(personalToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let urlSession = URLSession(configuration: .default)
        
        return urlSession.dataTaskPublisher(for: request)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
