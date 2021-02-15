//
//  FactsApi.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Client

protocol FactsApiProtocol {
    func fetchFacts(query: String, completion: @escaping (Result<FactsQuery, ClientError>) -> Void)
}

class FactsApi: FactsApiProtocol {
    
    // MARK: - Parameters
    private let client: ClientProtocol
    
    // MARK: - Init
    init(client: ClientProtocol) {
        self.client = client
    }
    
    static func make() -> FactsApi {
        return FactsApi(client: ClientFactory.create())
    }
}

// MARK: - Requests

extension FactsApi {
    func fetchCategories(completion: @escaping (Result<[String], ClientError>) -> Void) {
        let url = FactsEndpoint.categories.url
        client.request(url: url, method: .get, headers: [:], parameters: [:], completion: completion)
    }
    
    func fetchFacts(query: String, completion: @escaping (Result<FactsQuery, ClientError>) -> Void) {
        let url = FactsEndpoint.search(query: query).url
        client.request(url: url, method: .get, headers: [:], parameters: [:], completion: completion)
    }
}
