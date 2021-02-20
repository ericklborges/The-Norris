//
//  FactsSearchViewControllerFlowDelegateSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

@testable import The_Norris

final class FactsSearchViewControllerFlowDelegateSpy: FactsSearchViewControllerFlowDelegate {
    
    private(set) var calledFactsSearchDidEndWith: Bool = false
    
    func factsSearch(_ controller: FactsSearchViewController, didEndWith query: String) {
        calledFactsSearchDidEndWith = true
    }
}
