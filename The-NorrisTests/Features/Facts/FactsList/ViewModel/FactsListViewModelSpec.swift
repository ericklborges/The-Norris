//
//  FactsListViewModelSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Quick
import Nimble

@testable import The_Norris

class FactsListViewModelSpec: QuickSpec {
    override func spec() {
        describe("FactsListViewModel") {
            
            var sut: FactsListViewModel!
            var apiMock: FactsApiMock!
            var delegateSpy: FactsListViewModelDelegateSpy!
            
            context("when initialized") {
                beforeEach {
                    apiMock = FactsApiMock()
                    delegateSpy = FactsListViewModelDelegateSpy()
                    sut = FactsListViewModel(api: apiMock)
                    sut.delegate = delegateSpy
                }
                
                context("facts are fetched") {
                    
                    context("and it returns a successful factsQuery") {
                        beforeEach {
                            apiMock.shouldFail = false
                            apiMock.fetchFactsReturn = .stub(total: 2, result: [.stub(), .stub()])
                            sut.fetchFacts(query: "")
                        }
                        
                        it("should call delegate's didChange(facts:) method") {
                            expect(delegateSpy.calledDidChangeFacts) == true
                        }
                        
                        it("should call delegate's didStartRequest() method") {
                            expect(delegateSpy.calledDidStartRequest) == true
                        }
                    }
                    
                    context("and it returns a factsQuery with zero results") {
                        beforeEach {
                            apiMock.shouldFail = false
                            apiMock.fetchFactsReturn = .stub(total: 0, result: [])
                            sut.fetchFacts(query: "")
                        }
                        
                        it("should call delegate's didReceiveEmptyResult() method") {
                            expect(delegateSpy.calledDidReceiveEmptyResult) == true
                        }
                        
                        it("should call delegate's didStartRequest() method") {
                            expect(delegateSpy.calledDidStartRequest) == true
                        }
                    }
                    
                    context("and it returns an error") {
                        beforeEach {
                            apiMock.shouldFail = true
                            sut.fetchFacts(query: "")
                        }
                        
                        it("should call delegate's didReceiveError() method") {
                            expect(delegateSpy.calledDidReceiveError) == true
                        }
                        
                        it("should call delegate's didStartRequest() method") {
                            expect(delegateSpy.calledDidStartRequest) == true
                        }
                    }
                }
            }
        }
    }
}
