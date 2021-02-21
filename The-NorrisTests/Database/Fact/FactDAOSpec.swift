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
                
                context("and Facts are created") {
                    
                    beforeEach {
                        sut.create(.stub(id: "1"), for: "query 1")
                        sut.create(.stub(id: "2"), for: "query 2")
                        sut.create(.stub(id: "3"), for: "query 3")
                    }
                    
                    it("should retrieve the created Facts") {
                        expect(sut.getAll()?.count) == 3
                    }
                }
            }
        }
    }
}
