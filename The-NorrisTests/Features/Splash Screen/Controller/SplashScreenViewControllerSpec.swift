//
//  SplashScreenViewControllerSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 16/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import The_Norris

final class SplashScreenViewControllerSpec: QuickSpec {
    override func spec() {
        describe("SplashScreenViewController") {
            
            var sut: SplashScreenViewController!
            var flowDelegateSpy: SplashScreenFlowDelegateSpy!
            
            context("when initialized") {
                
                beforeEach {
                    flowDelegateSpy = SplashScreenFlowDelegateSpy()
                    sut = SplashScreenViewController()
                    sut.flowDelegate = flowDelegateSpy
                    WindowHelper.showInTestWindow(sut)
                }
                
                context("and view loads") {
                    beforeEach {
                        sut.beginAppearanceTransition(true, animated: false)
                        sut.endAppearanceTransition()
                    }
                    
                    it("should layout itself properly") {
                        expect(sut).toEventually(haveValidSnapshot(named: "SplashScreenViewController_Layout"), timeout: .seconds(5))
                    }
                }
                
                context("SplashScreenViewModelDelegate") {
                    
                    context("didFinishSetup() is called") {
                        beforeEach {
                            sut.didFinishSetup()
                        }
                        
                        it("should call flowDelegate's splashScreenDidFinishSetup(_:) method") {
                            expect(flowDelegateSpy.calledSplashScreenDidFinishSetup) == true
                        }
                    }
                }
            }
        }
    }
}
