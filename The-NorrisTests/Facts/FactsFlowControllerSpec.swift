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
                }
                
                context("and view loads") {
                    var navigation: UINavigationController?
                    
                    beforeEach {
                        sut.beginAppearanceTransition(true, animated: false)
                        sut.endAppearanceTransition()
                        navigation = sut.children.first as? UINavigationController
                    }
                    
                    it("should show the correct first view controller") {
                        expect(navigation?.viewControllers.first).to(beAKindOf(FactsListViewController.self))
                    }
                }
            }
        }
    }
}
