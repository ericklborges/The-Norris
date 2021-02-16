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
                    
                    it("should show splash screen") {
                        expect(sut.children.first).toEventually(beAKindOf(SplashScreenViewController.self), timeout: .milliseconds(100))
                    }
                    
                    context("and splash screen finishes setup") {
                        beforeEach {
                            sut.splashScreenDidFinishSetup(SplashScreenViewController())
                        }
                        
                        it("should show FactsFlowController") {
                            expect(sut.children.first).toEventually(beAKindOf(FactsFlowController.self), timeout: .milliseconds(100))
                        }
                    }
                }
            }
        }
    }
}
