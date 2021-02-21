//
//  FactsListServiceSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 20/02/21.
//

import Quick
import Nimble
import Client

@testable import The_Norris

final class FactsListServiceSpec: QuickSpec {
    override func spec() {
        describe("FactsListService") {
            
            var sut: FactsListService!
            var apiMock: FactsApiMock!
            var daoMock: FactDAO!
            var delegateSpy: FactsListServiceDelegateSpy!
            
            context("when initialized") {
                beforeEach {
                    apiMock = FactsApiMock()
                    daoMock = FactDAO.make()
                    delegateSpy = FactsListServiceDelegateSpy()
                    sut = FactsListService(api: apiMock)
                    sut.delegate = delegateSpy
                }
                
                context("facts are fetched") {
                    
                    context("and it returns a successful factsQuery") {
                        beforeEach {
                            apiMock.shouldFail = false
                            apiMock.fetchFactsReturn = .stub(total: 2, result: [.stub(), .stub()])
                            sut.fetchFacts(query: "")
                        }
                        
                        it("should call delegate's didReceive(facts:) method") {
                            expect(delegateSpy.calledDidReceiveFacts) == true
                        }
                        
                        it("should save received facts on local database") {
                            expect(daoMock.getAll()?.count) == 2
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
                    }
                    
                    context("and it returns an error") {
                        
                        context("with status code 400") {
                            beforeEach {
                                apiMock.shouldFail = true
                                apiMock.error = ClientError(reason: .api(""), statusCode: 400)
                                sut.fetchFacts(query: "")
                            }
                            
                            it("should call delegate's didReceiveInvalidQuery() method") {
                                expect(delegateSpy.calledDidReceiveInvalidQuery) == true
                            }
                            
                            it("should not call delegate's didReceiveError() method") {
                                expect(delegateSpy.calledDidReceiveError) == false
                            }
                        }
                        
                        context("with status any status code but 400") {
                            beforeEach {
                                apiMock.shouldFail = true
                                apiMock.error = ClientError(reason: .api(""), statusCode: 99)
                                sut.fetchFacts(query: "")
                            }
                            
                            it("should not call delegate's didReceiveInvalidQuery() method") {
                                expect(delegateSpy.calledDidReceiveInvalidQuery) == false
                            }
                            
                            it("should call delegate's didReceiveError() method") {
                                expect(delegateSpy.calledDidReceiveError) == true
                            }
                        }
                    }
                    
                    context("and fetchFactsRetry() is called") {
                        beforeEach {
                            sut.fetchFacts(query: "lastQuery")
                            apiMock.passedQuery = nil
                            sut.fetchFactsRetry()
                        }
                        
                        it("should fetchFacts with the same query as last time") {
                            expect(apiMock.passedQuery) == "lastQuery"
                        }
                    }
                }
            }
        }
    }
}
