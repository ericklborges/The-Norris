//
//  FactsListViewControllerSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots
import Interface

@testable import The_Norris

class FactsListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FactsListViewController") {
            
            var sut: FactsListViewController!
            var navigationMock: UINavigationController!
            
            context("when initialized") {
                
                beforeEach {
                    sut = FactsListViewController()
                    navigationMock = UINavigationController(rootViewController: sut)
                    navigationMock.applyCustomAppearence()
                    WindowHelper.showInTestWindow(navigationMock)
                }
                
                it("should layout it's navigation properly") {
                    expect(sut.navigationController?.navigationBar) == snapshot("FactsListViewController_Navigation_Layout")
                }
                
                context("and view loads") {
                    beforeEach {
                        sut.beginAppearanceTransition(true, animated: false)
                        sut.endAppearanceTransition()
                    }
                    
                    it("should set it's state to empty") {
                        expect(sut.state) == .empty(title: "", message: nil, buttonConfiguration: nil)
                    }
                    
                    it("should layout itself properly") {
                        expect(navigationMock).toEventually(haveValidSnapshot(named: "FactsListViewController_Layout_First_Time_Empty"), timeout: .milliseconds(100))
                    }
                }
                
                context("FactsListViewModelDelegate") {
                    
                    context("when didChange(facts:) is called") {
                        beforeEach {
                            sut.didChange(facts: .stub())
                        }
                        
                        it("should set it's state to main") {
                            expect(sut.state) == .main
                        }
                        
                        it("should layout itself properly") {
                            expect(navigationMock).toEventually(haveValidSnapshot(named: "FactsListViewController_Layout_Main"), timeout: .milliseconds(250))
                        }
                    }
                    
                    context("when didStartRequest() is called") {
                        beforeEach {
                            sut.didStartRequest()
                        }
                        
                        it("should set it's state to main") {
                            expect(sut.state) == .loading(title: "", message: nil)
                        }
                        
                        it("should layout itself properly") {
                            expect(navigationMock).toEventually(haveValidSnapshot(named: "FactsListViewController_Layout_Loading"), timeout: .milliseconds(100))
                        }
                    }
                    
                    context("when didReceiveEmptyResult() is called") {
                        beforeEach {
                            sut.didReceiveEmptyResult()
                        }
                        
                        it("should set it's state to main") {
                            expect(sut.state) == .empty(title: "", message: nil, buttonConfiguration: nil)
                        }
                        
                        it("should layout itself properly") {
                            expect(navigationMock).toEventually(haveValidSnapshot(named: "FactsListViewController_Layout_Empty"), timeout: .milliseconds(100))
                        }
                    }
                    
                    context("when didReceiveError is called") {
                        beforeEach {
                            sut.didReceiveError()
                        }
                        
                        it("should set it's state to main") {
                            expect(sut.state) == .error(image: nil, title: "", message: nil, buttonConfiguration: ButtonConfiguration(title: "", action: {}))
                        }
                        
                        it("should layout itself properly") {
                            expect(navigationMock).toEventually(haveValidSnapshot(named: "FactsListViewController_Layout_Error"), timeout: .milliseconds(100))
                        }
                    }
                }
                
                context("FactsListViewShareDelegate") {
                    
                    context("when factsList(_:wantsToShare:) is called") {
                        beforeEach {
                            sut.factsList(FactsListView(), wantsToShare: .stub())
                        }
                        
                        it("should present an UIActivityViewController") {
                            expect(sut.presentedViewController).to(beAKindOf(UIActivityViewController.self))
                        }
                    }
                }
            }
        }
    }
}
