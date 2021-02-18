//
//  PastQueryDAOSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 18/02/21.
//

import Quick
import Nimble

@testable import The_Norris

class PastQueryDAOSpec: QuickSpec {
    override func spec() {
        
        describe("PastQueryDAO") {
            
            var sut: PastQueryDAO!
            
            context("when initialized") {
                
                beforeEach {
                    sut = PastQueryDAO.make()
                }
                
                context("and PastTerms are created") {
                    
                    beforeEach {
                        sut.create("past term")
                    }
                    
                    it("should retrieve the created PastTerms") {
                        expect(sut.getAll()?.count) == 1
                        expect(sut.getAll()?.first) == "past term"
                    }
                }
            }
        }
    }
}
