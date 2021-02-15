//
//  FactsApiSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Quick
import Nimble

@testable import The_Norris

class FactsApiSpec: QuickSpec {
    override func spec() {
        describe("FactsApi") {
            
            var sut: FactsApi!
            var clientMock: ClientMock!
            
            context("when initialized") {
                beforeEach {
                    clientMock = ClientMock()
                    sut = FactsApi(client: clientMock)
                }
                
                context("and facts are fetched") {
                    beforeEach {
                        clientMock.mockFileName = "facts-query"
                        sut.fetchFacts(query: "query") { _ in }
                    }
                    
                    it("should setup the url correctly") {
                        expect(clientMock.url?.absoluteString) == "https://api.chucknorris.io/jokes/search?query=query"
                    }
                    
                    it("should use .get http method") {
                        expect(clientMock.method?.rawValue) == "GET"
                    }
                    
                    it("should not have headers") {
                        expect(clientMock.headers?.isEmpty) == true
                    }
                    
                    it("should not have body parameters") {
                        expect(clientMock.parameters?.isEmpty) == true
                    }
                    
                    context("and it succeeds") {
                        beforeEach {
                            clientMock.shouldFail = false
                        }
                        
                        it("it should parse the response correctly") {
                            sut.fetchFacts(query: "query") { result in
                                switch result {
                                case let .success(factsQuery):
                                    expect(factsQuery.result.isEmpty) == false
                                case .failure:
                                    fail("The object is not matching the API response.")
                                }
                            }
                        }
                    }
                    
                    context("and it fails") {
                        beforeEach {
                            clientMock.shouldFail = true
                        }
                        
                        it("return an error") {
                            sut.fetchFacts(query: "query") { result in
                                switch result {
                                case .success:
                                    fail("The request was supposed to fail.")
                                case let .failure(error):
                                    expect(error.reason) == .api(error.reason.description)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
