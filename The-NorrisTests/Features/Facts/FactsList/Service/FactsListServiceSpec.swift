//
//  FactsListServiceSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 20/02/21.
//

import Quick
import Nimble

@testable import Client
@testable import The_Norris

final class FactsListServiceSpec: QuickSpec {
    override func spec() {
        describe("FactsListService") {
            
            var sut: FactsListService!
            var daoMock: FactDAOMock!
            var apiMock: FactsApiMock!
            var delegateSpy: FactsListServiceDelegateSpy!
            
            context("when initialized") {
                beforeEach {
                    apiMock = FactsApiMock()
                    daoMock = FactDAOMock()
                    sut = FactsListService(api: apiMock, dao: daoMock)
                    delegateSpy = FactsListServiceDelegateSpy()
                    sut.delegate = delegateSpy
                }
                
                context("and user is offline") {
                    beforeEach {
                        NetworkMonitor.shared.testsIsReachable = { false }
                    }
                    
                    context("and facts are fetched") {
                        
                        context("and there are no facts available on the Database") {
                            beforeEach {
                                sut.fetchFacts(query: "")
                            }
                            
                            it("should request facts for dao") {
                                expect(daoMock.calledGetAllForQuery) == true
                            }
                            
                            it("should call delegate's didReceiveEmptyResultFromDatabase() method") {
                                expect(delegateSpy.calledDidReceiveEmptyResultFromDatabase) == true
                            }
                        }
                        
                        context("and facts are available on the Database") {
                            beforeEach {
                                daoMock.create(.stub(), for: "query 1")
                                daoMock.create(.stub(), for: "query 1")
                                sut.fetchFacts(query: "query 1")
                            }
                            
                            it("should request facts for dao") {
                                expect(daoMock.calledGetAllForQuery) == true
                            }
                            
                            it("should call delegate's didReceive(facts:) method") {
                                expect(delegateSpy.calledDidReceiveFacts) == true
                            }
                        }
                    }
                    
                    context("and ten random facts are fetched") {
                        
                        context("and there are no facts available on the Database") {
                            beforeEach {
                                sut.fetchTenRandomFacts()
                            }
                            
                            it("should request facts for dao") {
                                expect(daoMock.calledGetAll) == true
                            }
                            
                            it("should call delegate's didReceiveDatabaseIsEmpty() method") {
                                expect(delegateSpy.calledDidReceiveDatabaseIsEmpty) == true
                            }
                        }
                        
                        context("and less than 10 facts are available on the Database") {
                            beforeEach {
                                daoMock.create(.stub(), for: "query 1")
                                daoMock.create(.stub(), for: "query 1")
                                sut.fetchTenRandomFacts()
                            }
                            
                            it("should request facts for dao") {
                                expect(daoMock.calledGetAll) == true
                            }
                            
                            it("should call delegate's didReceive(facts:) method") {
                                expect(delegateSpy.calledDidReceiveFacts) == true
                            }
                            
                            it("delegate should receive lass than 10 facts") {
                                expect(delegateSpy.receivedFacts?.count) < 10
                            }
                        }
                        
                        context("and at least 10 facts are available on the Database") {
                            beforeEach {
                                let facts = Array(repeating: Fact.stub(), count: 15)
                                facts.forEach { daoMock.create($0, for: "query") }
                                sut.fetchTenRandomFacts()
                            }
                            
                            it("should request facts for dao") {
                                expect(daoMock.calledGetAll) == true
                            }
                            
                            it("delegate should receive lass than 10 facts") {
                                expect(delegateSpy.receivedFacts?.count) == 10
                            }
                        }
                    }
                }
                
                context("and user is online") {
                    beforeEach {
                        NetworkMonitor.shared.testsIsReachable = { true }
                    }
                    
                    context("and facts are fetched") {
                        
                        context("and it returns a successful factsQuery") {
                            beforeEach {
                                apiMock.shouldFail = false
                                apiMock.fetchFactsReturn = .stub(total: 2, result: [.stub(), .stub()])
                                sut.fetchFacts(query: "")
                            }
                            
                            it("should request facts for api") {
                                expect(apiMock.calledFetchFacts) == true
                            }
                            
                            it("should call delegate's didReceive(facts:) method") {
                                expect(delegateSpy.calledDidReceiveFacts) == true
                            }
                            
                            it("should ask dao to save received facts") {
                                expect(daoMock.calledCreate) == true
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
                            
                            it("should request facts for api") {
                                expect(apiMock.calledFetchFacts) == true
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
                                
                                it("should request facts for api") {
                                    expect(apiMock.calledFetchFacts) == true
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
                                
                                it("should request facts for api") {
                                    expect(apiMock.calledFetchFacts) == true
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
                            
                            it("should request facts for api") {
                                expect(apiMock.calledFetchFacts) == true
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
}
