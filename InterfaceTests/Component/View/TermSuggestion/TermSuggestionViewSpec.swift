//
//  TermSuggestionViewSpec.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 11/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Interface

final class TermSuggestionViewSpec: QuickSpec {
    override func spec() {
        
        describe("TermSuggestionView") {
            
            var sut: TermSuggestionView!

            context("when initialized") {
                beforeEach {
                    sut = TermSuggestionView()
                    sut.text = "Term Suggestion"
                    sut.setDynamicSize(forWidth: 390.0)
                }
                
                context("and offset separator is set") {
                    beforeEach {
                        sut.setOffsetSeparator()
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("TermSuggestionView_Layout_Offset_Separator")
                    }
                }
                
                context("and full width separator is set") {
                    beforeEach {
                        sut.setFullWidthSeparator()
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("TermSuggestionView_Layout_Full_Width_Separator")
                    }
                }
            }
        }
    }
}
