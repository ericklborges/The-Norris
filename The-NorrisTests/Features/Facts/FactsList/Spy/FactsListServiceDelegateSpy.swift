//
//  FactsListServiceDelegateSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 20/02/21.
//

@testable import The_Norris

class FactsListServiceDelegateSpy: FactsListServiceDelegate {
    private(set) var calledDidReceiveFacts: Bool = false
    private(set) var calledDidReceiveError: Bool = false
    private(set) var calledDidReceiveEmptyResult: Bool = false
    private(set) var calledDidReceiveInvalidQuery: Bool = false
    
    func didReceive(facts: [Fact]) {
        calledDidReceiveFacts = true
    }
    
    func didReceiveError() {
        calledDidReceiveError = true
    }
    
    func didReceiveEmptyResult() {
        calledDidReceiveEmptyResult = true
    }
    
    func didReceiveInvalidQuery() {
        calledDidReceiveInvalidQuery = true
    }
}
