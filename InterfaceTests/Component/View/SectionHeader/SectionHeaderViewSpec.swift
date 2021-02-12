//
//  SectionHeaderViewSpec.swift
//  Interface
//
//  Created by erick.lozano.borges on 11/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Interface

class SectionHeaderSpec: QuickSpec {
    override func spec() {
        
        describe("SectionHeader") {
            
            var sut: SectionHeaderView!

            context("when initialized") {
                beforeEach {
                    sut = SectionHeaderView()
                    sut.text = "Section Title"
                    sut.setDynamicSize(forHeight: 38.0)
                }
                
                it("should layout itself properly") {
                    expect(sut) == snapshot("SectionHeader_Layout")
                }
            }
        }
    }
}

