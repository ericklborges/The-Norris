//
//  FactsListViewShareDelegateSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

@testable import The_Norris

class FactsListViewShareDelegateSpy: FactsListViewShareDelegate {
    
    private(set) var calledFactsListWantsToShare: Bool = false
    
    func factsList(_ view: FactsListView, wantsToShare fact: Fact) {
        calledFactsListWantsToShare = true
    }
}
