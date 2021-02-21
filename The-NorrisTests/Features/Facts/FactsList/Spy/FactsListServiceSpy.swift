//
//  FactsListServiceSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 20/02/21.
//

@testable import The_Norris

class FactsListServiceSpy: FactsListServiceProtocol {
    
    private(set) var calledFetchFactsRetry: Bool = true
    private(set) var calledFetchFacts: Bool = true
    
    var delegate: FactsListServiceDelegate? = nil
    
    func fetchFactsRetry() {
        calledFetchFactsRetry = true
    }
    
    func fetchFacts(query: String) {
        calledFetchFacts = true
    }
}
