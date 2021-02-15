//
//  FactsApiMock.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Client

@testable import The_Norris

class FactsApiMock: FactsApiProtocol {
    
    var shouldFail: Bool = false
    var fetchFactsReturn: FactsQuery = .stub()
    
    func fetchFacts(query: String, completion: @escaping (Result<FactsQuery, ClientError>) -> Void) {
        if shouldFail {
            completion(.failure(ClientError(reason: .api("FactsApiMock should sFail"), statusCode: 99)))
        } else {
            completion(.success(fetchFactsReturn))
        }
    }
}
