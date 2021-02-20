//
//  ClientSpec.swift
//  ClientTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Quick
import Nimble

@testable import Client

private struct Object: Decodable {
    var boolean: Bool
}

final class ClientSpec: QuickSpec {
    override func spec() {
    
        describe("Client") {
            
            var sut: Client!
            var sessionMock: URLSessionMock!
            
            context("when initializex") {
                beforeEach {
                    sessionMock = URLSessionMock()
                    sut = Client(session: sessionMock)
                    sut.logger = RequestLogger(level: .none)
                }
                
                context("and parameters are passed") {
                    
                    context("using get method") {
                        beforeEach {
                            sut.request(url: .stub(), method: .get, headers: [:], parameters: ["key": "value"]) { (result: Result<String, ClientError>) in }
                        }
                        
                        it("shold not have httpBody") {
                            expect(sessionMock.passedRequest?.httpBody).to(beNil())
                        }
                    }
                    
                    context("using a method different from get") {
                        beforeEach {
                            sut.request(url: .stub(), method: .post, headers: [:], parameters: ["key": "value"]) { (result: Result<String, ClientError>) in }
                        }
                        
                        it("shold have a httpBody") {
                            expect(sessionMock.passedRequest?.httpBody).toNot(beNil())
                        }
                    }
                }
                
                context("and a request is successful") {
                    beforeEach {
                        sessionMock.data = "{ \"boolean\": true}".data(using: .utf8)
                    }
                    
                    it("should parsed the Object correctly") {
                        sut.request(url: .stub(), method: .get) { (result: Result<Object, ClientError>) in
                            switch result {
                            case let .success(object):
                                expect(object.boolean) == true
                            case .failure:
                                fail("The request did fail because the Object couldn't be parsed")
                            }
                        }
                    }
                }
                
                context("and the request fails with unknown error") {
                    beforeEach {
                        sessionMock.response = nil
                    }
                    
                    it("should return a decoding error") {
                        sut.request(url: .stub(), method: .get) { (result: Result<Object, ClientError>) in
                            switch result {
                            case .success:
                                fail("The request should not be successfull")
                            case let .failure(error):
                                expect(error.reason) == .api(error.localizedDescription)
                                expect(error.statusCode) == 666
                            }
                        }
                    }
                }
                
                context("and the request returns an error") {
                    beforeEach {
                        sessionMock.error = NSError(domain: "ClientTests", code: 404, userInfo: [:])
                    }
                    
                    it("should return an api error") {
                        sut.request(url: .stub(), method: .get) { (result: Result<Object, ClientError>) in
                            switch result {
                            case .success:
                                fail("The request should not be successfull")
                            case let .failure(error):
                                expect(error.reason) == .api(error.localizedDescription)
                            }
                        }
                    }
                }
                
                context("and the request returns an invalid data") {
                    beforeEach {
                        sessionMock.data = nil
                    }
                    
                    it("should return an api error") {
                        sut.request(url: .stub(), method: .get) { (result: Result<Object, ClientError>) in
                            switch result {
                            case .success:
                                fail("The request should not be successfull")
                            case let .failure(error):
                                expect(error.reason) == .invalidData
                            }
                        }
                    }
                }
                
                context("and a request fails to decode object") {
                    beforeEach {
                        sessionMock.data = "{ \"boolean\": 100}".data(using: .utf8)
                    }
                    
                    it("should return a decoding error") {
                        sut.request(url: .stub(), method: .get) { (result: Result<Object, ClientError>) in
                            switch result {
                            case .success:
                                fail("The request should not be successfull")
                            case let .failure(error):
                                expect(error.reason) == .decoding(error)
                            }
                        }
                    }
                }

            }
        }
    }
}
