//
//  FactsListViewModelDelegateSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import UIKit

@testable import The_Norris

final class FactsListViewModelDelegateSpy: FactsListViewModelDelegate {
    private(set) var calledDidReceiveFacts: Bool = false
    private(set) var calledDidStartLoading: Bool = false
    private(set) var calledDidReceiveError: Bool = false
    private(set) var calledDidReceiveEmptyResult: Bool = false
    
    func didReceive(facts: [Fact]) {
        calledDidReceiveFacts = true
    }
    
    func didStartLoading(title: String, message: String) {
        calledDidStartLoading = true
    }
    
    func didReceiveError(image: UIImage, title: String, message: String, buttonTitle: String) {
        calledDidReceiveError = true
    }
    
    func didReceiveEmptyResult(title: String, message: String, buttonTitle: String) {
        calledDidReceiveEmptyResult = true
    }
}
