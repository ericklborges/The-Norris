//
//  AppFlowControllerSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Quick
import Nimble

@testable import The_Norris

class AppFlowControllerSpec: QuickSpec {
    override func spec() {
        describe("AppFlowController") {
            
            var sut: AppFlowController!
            
            context("when initialized") {
                
                beforeEach {
                    sut = AppFlowController()
                }
                
                context("and view appears") {
                    beforeEach {
                        sut.beginAppearanceTransition(true, animated: false)
                        sut.endAppearanceTransition()
                    }
                    
                    it("should add the correct child view controller") {
                        expect(sut.children.first).to(beAKindOf(FactsFlowController.self))
                    }
                }
            }
        }
    }
}
