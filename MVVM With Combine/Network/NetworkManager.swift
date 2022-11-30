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
    
    private let baseUrl = "https://api.json-generator.com"
    
    func fetchCountries<T: Decodable>() -> AnyPublisher<T, Error> {
        let routPath = "/templates/GlOxEqjDIq8M/data"
        let path = baseUrl + routPath
        
        guard let url = URL(string: path),
              let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Could not create url or access API key.")
        }
        
        let personalToken = "Bearer " + apiKey
        
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
