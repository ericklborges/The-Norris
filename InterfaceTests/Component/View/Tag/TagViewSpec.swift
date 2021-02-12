//
//  TagViewSpec.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 10/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Interface

class TagViewSpec: QuickSpec {
    override func spec() {
        
        describe("TagView") {
            
            var sut: TagView!

            context("when initialized") {
                beforeEach {
                    sut = TagView()
                    sut.text = "Category"
                    sut.setDynamicSize(forHeight: 24.0)
                }
                
                it("should layout itself properly") {
                    expect(sut) == snapshot("TagView_Layout")
                }
            }
        }
    }
}
