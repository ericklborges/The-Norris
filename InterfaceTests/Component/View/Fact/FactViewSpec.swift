//
//  FactViewSpec.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 11/02/21.
//

import Foundation

import Quick
import Nimble
import Nimble_Snapshots

@testable import Interface

final class FactViewSpec: QuickSpec {
    override func spec() {
        
        describe("FactView") {
            
            var sut: FactView!

            context("when initialized") {
                beforeEach {
                    sut = FactView()
                    sut.categoryText = "Category"
                }
                
                context("and set factText with less than 80 characters") {
                    beforeEach {
                        sut.factText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit ae."
                        sut.setDynamicSize(forWidth: 343.0)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("FactView_Layout_Small_Text")
                    }
                }
                
                context("and set factText with more than 80 characters") {
                    beforeEach {
                        sut.factText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
                            + "Aenean commodo ligula eget dolor. Aenean massa."
                            + "Cum sociis natoque penatibus et magnis dis parturient."
                        sut.setDynamicSize(forWidth: 343.0)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("FactView_Layout_Large_Text")
                    }
                }
            }
        }
    }
}
