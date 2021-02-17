//
//  FactsSearchViewControllerSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import The_Norris

class FactsSearchViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FactsSearchViewController") {
            
            var sut: FactsSearchViewController!
            var navigationMock: UINavigationController!
            var flowDelegateSpy: FactsSearchViewControllerFlowDelegateSpy!
            
            context("when initialized") {
                
                beforeEach {
                    sut = FactsSearchViewController()
                    
                    flowDelegateSpy = FactsSearchViewControllerFlowDelegateSpy()
                    sut.flowDelegate = flowDelegateSpy
                    
                    navigationMock = UINavigationController(rootViewController: sut)
                    navigationMock.navigationBar.backgroundColor = .white
                    WindowHelper.showInTestWindow(navigationMock)
                }
                
                it("should layout it's navigation properly") {
                    expect(sut.navigationController?.navigationBar) == snapshot("FactsSearchViewController_Navigation_Layout")
                }
                
                context("and textFieldShouldReturn(_:) is caled") {
                    beforeEach {
                        _ = sut.textFieldShouldReturn(UITextField())
                    }
                    
                    it("should call flowDelegate's factsSearch(_:didEndWith:) method") {
                        expect(flowDelegateSpy.calledFactsSearchDidEndWith) == true
                    }
                }
                
                context("and didSelectSuggestion(_:) is caled") {
                    beforeEach {
                        sut.didSelectSuggestion("")
                    }
                    
                    it("should call flowDelegate's factsSearch(_:didEndWith:) method") {
                        expect(flowDelegateSpy.calledFactsSearchDidEndWith) == true
                    }
                }
            }
        }
    }
}

