//
//  FactsListViewSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import The_Norris

final class FactsListViewSpec: QuickSpec {
    override func spec() {
        describe("FactsListView") {
            
            var sut: FactsListView!
            var shareDelegateSpy: FactsListViewShareDelegateSpy!
            
            context("when initialized") {
                
                beforeEach {
                    sut = FactsListView()
                    sut.setup(facts: .stub())
                    
                    shareDelegateSpy = FactsListViewShareDelegateSpy()
                    sut.shareDelegate = shareDelegateSpy
                    
                    sut.frame.size = CGSize(width: 375, height: 812)
                }
                
                it("should layout itself properly") {
                    expect(sut) == snapshot("FactsListView_Layout")
                }
                
                context("FactTableViewCellActionDelegate") {
                    
                    context("factCell(_:buttonTappedWith:) method is called") {
                        beforeEach {
                            sut.factCell(FactTableViewCell(), buttonTappedWith: .stub())
                        }
                        
                        it("should call delegate's") {
                            expect(shareDelegateSpy.calledFactsListWantsToShare) == true
                        }
                    }
                }
            }
        }
    }
}

