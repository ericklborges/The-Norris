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

final class FactsListViewControllerSpec: QuickSpec {
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
                
                context("FactsListViewModelDelegate") {
                    
                    context("when didReceive(facts:) is called") {
                        beforeEach {
                            sut.didReceive(facts: .stub())
                        }
                        
                        it("should set it's state to main") {
                            expect(sut.state) == .main
                        }
                        
                        it("should layout itself properly") {
                            expect(navigationMock).toEventually(haveValidSnapshot(named: "FactsListViewController_Layout_Main"))
                        }
                    }
                    
                    context("when didStartLoading(title:message:) is called") {
                        beforeEach {
                            sut.didStartLoading(title: "Loading title", message: "Loading message")
                        }
                        
                        it("should set it's state to main") {
                            expect(sut.state) == .loading(title: "", message: nil)
                        }
                        
                        it("should layout itself properly") {
                            expect(navigationMock).toEventually(haveValidSnapshot(named: "FactsListViewController_Layout_Loading"))
                        }
                    }
                    
                    context("when didReceiveEmptyResult(title:message:buttonTitle:) is called") {
                        beforeEach {
                            sut.didReceiveEmptyResult(title: "Empty title", message: "Empty message", buttonTitle: "Empty button")
                        }
                        
                        it("should set it's state to main") {
                            expect(sut.state) == .empty(title: "", message: nil, buttonConfiguration: nil)
                        }
                        
                        it("should layout itself properly") {
                            expect(navigationMock).toEventually(haveValidSnapshot(named: "FactsListViewController_Layout_Empty"))
                        }
                    }
                    
                    context("when didReceiveError(image:title:message:buttonTitle:) is called") {
                        beforeEach {
                            sut.didReceiveError(image: Symbol.clockArrowCirclepath.image(pointSize: 48), title: "Error title", message: "Error message", buttonTitle: "Error Button")
                        }
                        
                        it("should set it's state to main") {
                            expect(sut.state) == .error(image: nil, title: "", message: nil, buttonConfiguration: ButtonConfiguration(title: "", action: {}))
                        }
                        
                        it("should layout itself properly") {
                            expect(navigationMock).toEventually(haveValidSnapshot(named: "FactsListViewController_Layout_Error"))
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
