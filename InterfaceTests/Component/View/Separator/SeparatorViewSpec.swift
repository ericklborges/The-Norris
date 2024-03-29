//
//  SeparatorViewSpec.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 11/02/21.
//

import Foundation

import Quick
import Nimble
import Nimble_Snapshots

@testable import Interface

final class SeparatorViewSpec: QuickSpec {
    override func spec() {
        
        describe("SeparatorView") {
            
            var sut: SeparatorView!

            context("when initialized") {
                beforeEach {
                    sut = SeparatorView()
                    sut.setDynamicSize(forWidth: 100)
                }
                
                it("should layout itself properly") {
                    expect(sut) == snapshot("SeparatorView_Layout")
                }
            }
        }
    }
}
