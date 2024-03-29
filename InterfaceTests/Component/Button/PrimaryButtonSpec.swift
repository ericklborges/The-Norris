//
//  PrimaryButtonSpec.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 12/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Interface

final class PrimaryButtonSpec: QuickSpec {
    override func spec() {
        
        describe("PrimaryButton") {
            
            var sut: PrimaryButton!

            context("when initialized") {
                beforeEach {
                    sut = PrimaryButton()
                    sut.setTitle("Button title", for: .normal)
                    sut.setDynamicSize()
                }
                
                it("should layout itself properly") {
                    expect(sut) == snapshot("PrimaryButton_Layout")
                }
                
                context("and it is highlighted") {
                    beforeEach {
                        sut.isHighlighted = true
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("PrimaryButton_Layout_Highlighted")
                    }
                }
            }
        }
    }
}
