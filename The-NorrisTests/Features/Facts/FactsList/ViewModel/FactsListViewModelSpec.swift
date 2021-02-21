//
//  FactsListViewModelSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Quick
import Nimble

@testable import The_Norris

final class FactsListViewModelSpec: QuickSpec {
    override func spec() {
        describe("FactsListViewModel") {
            
            var sut: FactsListViewModel!
            var serviceSpy: FactsListServiceSpy!
            var delegateSpy: FactsListViewModelDelegateSpy!
            
            context("when initialized") {
                beforeEach {
                    serviceSpy = FactsListServiceSpy()
                    sut = FactsListViewModel(service: serviceSpy)
                    delegateSpy = FactsListViewModelDelegateSpy()
                    sut.delegate = delegateSpy
                }
                
                context("and fetchFacts(query:) is called") {
                    beforeEach {
                        sut.fetchFacts(query: "")
                    }
                    
                    it("should call service's fetchFacts(query:) method") {
                        expect(serviceSpy.calledFetchFacts) == true
                    }
                    
                    it("should call delegate's didStartLoading() method") {
                        expect(delegateSpy.calledDidStartLoading) == true
                    }
                }
                
                context("and fetchFactsRetry() is called") {
                    beforeEach {
                        sut.fetchFactsRetry()
                    }
                    
                    it("should call service's fetchFacts(query:) method") {
                        expect(serviceSpy.calledFetchFactsRetry) == true
                    }
                    
                    it("should call delegate's didStartLoading() method") {
                        expect(delegateSpy.calledDidStartLoading) == true
                    }
                }
                
                context("FactsListServiceDelegate") {
                    
                    context("didReceive(facts:) is called") {
                        beforeEach {
                            sut.didReceive(facts: [])
                        }
                        
                        it("should call delegate's didReceive(facts:) method") {
                            expect(delegateSpy.calledDidReceiveFacts) == true
                        }
                    }
                    
                    context("didReceiveError() is called") {
                        beforeEach {
                            sut.didReceiveError()
                        }
                        
                        it("should call delegate's didReceiveError(image:title:message:buttonTitle:) method") {
                            expect(delegateSpy.calledDidReceiveError) == true
                        }
                    }
                    
                    context("didReceiveEmptyResult() is called") {
                        beforeEach {
                            sut.didReceiveEmptyResult()
                        }
                        
                        it("should call delegate's didReceiveEmptyResult(title:message:buttonTitle:) method") {
                            expect(delegateSpy.calledDidReceiveEmptyResult) == true
                        }
                    }
                    
                    context("didReceiveInvalidQuery() is called") {
                        beforeEach {
                            sut.didReceiveInvalidQuery()
                        }
                        
                        it("should call delegate's didReceiveEmptyResult(title:message:buttonTitle:) method") {
                            expect(delegateSpy.calledDidReceiveEmptyResult) == true
                        }
                    }
                }
                
                context("activity items are requested") {
                    var items: [Any] = []
                    
                    context("for a fact with a valid url") {
                        beforeEach {
                            let validUrlString = URL.stub().absoluteString
                            items = sut.activityItems(for: .stub(url: validUrlString))
                        }
                        
                        it("should return an url") {
                            expect(items.first).to(beAKindOf(URL.self))
                        }
                    }
                    
                    context("for a fact with an invalid url") {
                        beforeEach {
                            items = sut.activityItems(for: .stub(value: "value", url: ""))
                        }
                        
                        it("should return the fact value String") {
                            expect(items.first as? String) == "value"
                        }
                    }
                }
            }
        }
    }
}
