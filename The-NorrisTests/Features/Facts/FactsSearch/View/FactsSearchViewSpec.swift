//
//  FactsSearchViewSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 17/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import The_Norris

class FactsSearchViewSpec: QuickSpec {
    override func spec() {
        
        describe("FactsSearchView") {
            
            var sut: FactsSearchView!
            var delegateSpy: FactsSearchViewDelegateSpy!

            context("when initialized") {
                beforeEach {
                    sut = FactsSearchView()
                    delegateSpy = FactsSearchViewDelegateSpy()
                    sut.delegate = delegateSpy
                    sut.setup(categories: .categoriesStub())
                    sut.frame.size = CGSize(width: 375, height: 812)
                }
                
                it("should layout itself properly") {
                    expect(sut) == snapshot("FactsSearchView_Layout")
                }
                
                context("and collectionView selects an item") {
                    beforeEach {
                        sut.collectionView(.stub(), didSelectItemAt: IndexPath(row: 0, section: 0))
                    }
                    
                    it("should call delegate's didSelectSuggestion(_:) method") {
                        expect(delegateSpy.calledDidSelectSuggestion) == true
                    }
                }
            }
        }
    }
}
