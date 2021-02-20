//
//  FactsListViewModelDelegateSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

@testable import The_Norris

final class FactsListViewModelDelegateSpy: FactsListViewModelDelegate {
    
    private(set) var calledDidChangeFacts: Bool = false
    private(set) var calledDidStartRequest: Bool = false
    private(set) var calledDidReceiveEmptyResult: Bool = false
    private(set) var calledDidReceiveError: Bool = false
    
    func didChange(facts: [Fact]) {
        calledDidChangeFacts = true
    }
    
    func didStartRequest() {
        calledDidStartRequest = true
    }
    
    func didReceiveEmptyResult() {
        calledDidReceiveEmptyResult = true
    }
    
    func didReceiveError() {
        calledDidReceiveError = true
    }
}
