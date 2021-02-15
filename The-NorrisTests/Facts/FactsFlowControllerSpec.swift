//
//  FactsFlowControllerSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Quick
import Nimble

@testable import The_Norris

class FactsFlowControllerSpec: QuickSpec {
    override func spec() {
        describe("FactsFlowController") {
            
            var sut: FactsFlowController!
            
            context("when initialized") {
                
                beforeEach {
                    sut = FactsFlowController()
                    WindowHelper.showInTestWindow(sut)
                }
                
                context("and view loads") {
                    var navigation: UINavigationController?
                    
                    beforeEach {
                        sut.beginAppearanceTransition(true, animated: false)
                        sut.endAppearanceTransition()
                        navigation = sut.children.first as? UINavigationController
                    }
                    
                    it("should add a navigation as firts child controller") {
                        expect(sut.children.first).to(beAKindOf(UINavigationController.self))
                    }
                    
                    it("navigation should show a FactsListViewController as root view controller") {
                        expect(navigation?.viewControllers.first).to(beAKindOf(FactsListViewController.self))
                    }
                    
                    context("and factsListShowsSearch(_:) is called") {
                        beforeEach {
                            sut.factsListShowsSearch(FactsListViewController())
                            navigation = sut.presentedViewController as? UINavigationController
                        }
                        
                        it("should present a navigation Controller FactsSearchViewController") {
                            expect(sut.presentedViewController).to(beAKindOf(UINavigationController.self))
                        }
                        
                        it("navigation should show a FactsSearchViewController as root view controller") {
                            expect(navigation?.viewControllers.first).toEventually(beAKindOf(FactsSearchViewController.self), timeout: .seconds(1))
                        }
                    }
                }
            }
        }
    }
}
