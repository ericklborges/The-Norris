//
//  PastQueryDAOSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 18/02/21.
//

import Quick
import Nimble

@testable import The_Norris

final class PastQueryDAOSpec: QuickSpec {
    override func spec() {
        
        describe("PastQueryDAO") {
            
            var sut: PastQueryDAO!
            
            context("when initialized") {
                
                beforeEach {
                    sut = PastQueryDAO.make()
                }
                
                context("and past queries are created") {

                    beforeEach {
                        sut.create("1")
                        sut.create("2")
                        sut.create("3")
                    }
                    
                    it("should retrieve the created PastQueries") {
                        expect(sut.getAll()?.count) == 3
                    }
                    
                    it("should order the created PastQueries descending from last created") {
                        expect(sut.getAll()) == ["3", "2", "1"]
                    }
                }
                
                context("and all past queries are request") {
                    
                    context("and there are past queries persisted") {
                        
                        beforeEach {
                            sut.create("1")
                            sut.create("2")
                        }

                        it("should return past queries") {
                            expect(sut.getAll()?.count) == 2
                        }
                    }

                    context("without past queries persisted") {
                        it("should return nil") {
                            expect(sut.getAll()).to(beNil())
                        }
                    }
                }
            }
        }
    }
}
