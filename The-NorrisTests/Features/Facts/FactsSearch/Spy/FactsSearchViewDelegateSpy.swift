//
//  FactsSearchViewDelegateSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 17/02/21.
//

import UIKit
import Foundation

@testable import The_Norris

final class FactsSearchViewDelegateSpy: FactsSearchViewDelegate {
    private(set) var calledDidSelectSuggestion: Bool = false
    private(set) var calledContentInset: Bool = false
    
    func didSelectSuggestion(_ query: String) {
        calledDidSelectSuggestion = true
    }
    
    func contentInset() -> UIEdgeInsets {
        calledContentInset = true
        return .zero
    }
}
