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
    var fetchCategoriesReturn: [String] = []
    
    private let error = ClientError(reason: .api("FactsApiMock should sFail"), statusCode: 99)
    
    func fetchCategories(completion: @escaping (Result<[String], ClientError>) -> Void) {
        if shouldFail {
            completion(.failure(error))
        } else {
            completion(.success(fetchCategoriesReturn))
        }
    }
    
    func fetchFacts(query: String, completion: @escaping (Result<FactsQuery, ClientError>) -> Void) {
        if shouldFail {
            completion(.failure(error))
        } else {
            completion(.success(fetchFactsReturn))
        }
    }
}