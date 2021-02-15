//
//  FactTableViewCellSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 15/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import The_Norris

class FactTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("FactTableViewCell") {
            
            var sut: FactTableViewCell!
            
            context("when initialized") {
                
                beforeEach {
                    sut = FactTableViewCell()
                }
                
                context("and it is setup with a fact that has a category") {
                    beforeEach {
                        sut.setup(fact: .stub(value: "With a valid category", categories: ["Category"]))
                        sut.setDynamicSize(forWidth: 375)
                    }
                    
                    it("") {
                        expect(sut) == snapshot("FactTableViewCell_Layout_Without_Category")
                    }
                }
                
                context("and it is setup with a fact that has no category") {
                    beforeEach {
                        sut.setup(fact: .stub(value: "Without a category", categories: []))
                        sut.setDynamicSize(forWidth: 375)
                    }
                    
                    it("") {
                        expect(sut) == snapshot("FactTableViewCell_Layout_With_Category")
                    }
                }
            }
        }
    }
}

