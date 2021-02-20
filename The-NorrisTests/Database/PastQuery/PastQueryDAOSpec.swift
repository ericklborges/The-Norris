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
                
                context("and PastQueries are created") {
                    
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
            }
        }
    }
}
