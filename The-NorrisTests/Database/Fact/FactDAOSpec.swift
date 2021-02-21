//
//  FactDAOSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 20/02/21.
//

import Foundation

import Quick
import Nimble

@testable import The_Norris

final class FactDAOSpec: QuickSpec {
    override func spec() {
        
        describe("FactDAO") {
            
            var sut: FactDAO!
            
            context("when initialized") {
                
                beforeEach {
                    sut = FactDAO.make()
                }
                
                context("and facts are created") {
                    
                    beforeEach {
                        sut.create(.stub(id: "1"), for: "query 1")
                        sut.create(.stub(id: "2"), for: "query 2")
                        sut.create(.stub(id: "3"), for: "query 3")
                    }
                    
                    it("should retrieve the created Facts") {
                        expect(sut.getAll()?.count) == 3
                    }
                }
                
                context("and all facts are request for a given query") {
                    
                    context("and there are facts persisted associated with that query") {
                        
                        beforeEach {
                            sut.create(.stub(id: "1"), for: "query 1")
                            sut.create(.stub(id: "2"), for: "query 1")
                            sut.create(.stub(id: "2"), for: "query 2")
                            sut.create(.stub(id: "2"), for: "query 3")
                        }

                        it("should return only the facts related to that query") {
                            expect(sut.getAll(for: "query 1")?.count) == 2
                        }
                    }
                    
                    context("and there are no facts persisted related the query") {
                        
                        beforeEach {
                            sut.create(.stub(id: "2"), for: "query 2")
                            sut.create(.stub(id: "2"), for: "query 3")
                        }

                        it("should return only the facts related to that query") {
                            expect(sut.getAll(for: "query 1")).to(beNil())
                        }
                    }

                    context("without facts persisted") {
                        it("should return nil") {
                            expect(sut.getAll()).to(beNil())
                        }
                    }
                }
                
                context("and all facts are request") {
                    
                    context("and there are facts persisted") {
                        
                        beforeEach {
                            sut.create(.stub(id: "1"), for: "query 1")
                            sut.create(.stub(id: "2"), for: "query 2")
                        }

                        it("should return facts") {
                            expect(sut.getAll()?.count) == 2
                        }
                    }

                    context("without facts persisted") {
                        it("should return nil") {
                            expect(sut.getAll()).to(beNil())
                        }
                    }
                }
            }
        }
    }
}
