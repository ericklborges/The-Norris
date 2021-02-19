//
//  FactsSearchViewDelegateSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 17/02/21.
//

import Foundation

@testable import The_Norris

final class FactsSearchViewDelegateSpy: FactsSearchViewDelegate {
    private(set) var calledDidSelectSuggestion: Bool = false
    
    func didSelectSuggestion(_ query: String) {
        calledDidSelectSuggestion = true
    }
}
