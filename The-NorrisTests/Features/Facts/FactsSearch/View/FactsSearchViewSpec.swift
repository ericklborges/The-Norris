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

final class FactsSearchViewSpec: QuickSpec {
    override func spec() {
        
        describe("FactsSearchView") {
            
            var sut: FactsSearchView!
            var delegateSpy: FactsSearchViewDelegateSpy!

            context("when initialized") {
                beforeEach {
                    sut = FactsSearchView()
                    delegateSpy = FactsSearchViewDelegateSpy()
                    sut.delegate = delegateSpy
                }
                
                context("and it is setup with both categories and past queries") {
                    
                    beforeEach {
                        sut.setup(categories: .categoriesStub())
                        sut.setup(pastQueries: .pastQueriesStub())
                        sut.frame.size = CGSize(width: 390.0, height: 844.0)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("FactsSearchView_Layout")
                    }
                    
                    it("should ask the delegate for the scroll view content insets") {
                        expect(delegateSpy.calledContentInset).toEventually(beTrue(), timeout: .milliseconds(100))
                    }
                }
                
                context("and it is setup with an empty array of categories") {
                    beforeEach {
                        sut.setup(categories: [])
                        sut.setup(pastQueries: .pastQueriesStub())
                        sut.frame.size = CGSize(width: 390.0, height: 844.0)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("FactsSearchView_Layout_Empty_Categories")
                    }
                    
                    it("should ask the delegate for the scroll view content insets") {
                        expect(delegateSpy.calledContentInset).toEventually(beTrue(), timeout: .milliseconds(100))
                    }
                }
                
                context("and it is setup with an empty array of past queries") {
                    beforeEach {
                        sut.setup(categories: .categoriesStub())
                        sut.setup(pastQueries: [])
                        sut.frame.size = CGSize(width: 390.0, height: 844.0)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("FactsSearchView_Layout_Empty_Past_Queries")
                    }
                    
                    it("should ask the delegate for the scroll view content insets") {
                        expect(delegateSpy.calledContentInset).toEventually(beTrue(), timeout: .milliseconds(100))
                    }
                }
                
                context("and it is setup with an empty array for both past queries and categories") {
                    beforeEach {
                        sut.setup(categories: [])
                        sut.setup(pastQueries: [])
                        sut.frame.size = CGSize(width: 390.0, height: 844.0)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("FactsSearchView_Layout_Empty_Past_Queries_And_Categories")
                    }
                    
                    it("should ask the delegate for the scroll view content insets") {
                        expect(delegateSpy.calledContentInset).toEventually(beTrue(), timeout: .milliseconds(100))
                    }
                }
                
                context("and collectionView selects an item") {
                    beforeEach {
                        sut.setup(categories: .categoriesStub())
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
