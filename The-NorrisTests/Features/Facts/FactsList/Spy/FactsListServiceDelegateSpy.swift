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
    private(set) var calledDidReceiveDatabaseIsEmpty: Bool = false
    private(set) var calledDidReceiveEmptyResultFromDatabase: Bool = false
    
    private(set) var receivedFacts: [Fact]?
    
    func didReceive(facts: [Fact]) {
        receivedFacts = facts
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
    
    func didReceiveDatabaseIsEmpty() {
        calledDidReceiveDatabaseIsEmpty = true
    }
    
    func didReceiveEmptyResultFromDatabase() {
        calledDidReceiveEmptyResultFromDatabase = true
    }
}
