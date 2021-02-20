//
//  FactsSearchSectionHeaderSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 17/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import The_Norris

final class FactsSearchSectionHeaderSpec: QuickSpec {
    override func spec() {
        
        describe("FactsSearchSectionHeader") {
            
            var sut: FactsSearchSectionHeader!

            context("when initialized") {
                beforeEach {
                    sut = FactsSearchSectionHeader()
                    sut.setup(title: "Section Title")
                    sut.setDynamicSize(forHeight: 38.0)
                }
                
                it("should layout itself properly") {
                    expect(sut) == snapshot("FactsSearchSectionHeader_Layout")
                }
            }
        }
    }
}

