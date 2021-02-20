//
//  FactsApiMock.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Client

@testable import The_Norris

final class FactsApiMock: FactsApiProtocol {
    
    private(set) var calledFetchCategories: Bool = false
    private(set) var calledFetchFacts: Bool = false
    
    var passedQuery: String?
    var shouldFail: Bool = false
    var fetchFactsReturn: FactsQuery = .stub()
    var fetchCategoriesReturn: [String] = []
    
    var error = ClientError(reason: .api("FactsApiMock should Fail"), statusCode: 99)
    
    func fetchCategories(completion: @escaping (Result<[String], ClientError>) -> Void) {
        calledFetchCategories = true
        if shouldFail {
            completion(.failure(error))
        } else {
            completion(.success(fetchCategoriesReturn))
        }
    }
    
    func fetchFacts(query: String, completion: @escaping (Result<FactsQuery, ClientError>) -> Void) {
        calledFetchFacts = true
        passedQuery = query
        if shouldFail {
            completion(.failure(error))
        } else {
            completion(.success(fetchFactsReturn))
        }
    }
}
