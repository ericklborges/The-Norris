//
//  StateViewControllerSpec.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 13/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Interface

class StateViewControllerSpec: QuickSpec {
    override func spec() {
        
        describe("StateViewController") {
            
            var sut: StateViewController!

            context("when initialized") {
                let image = Symbol.wifiSlash.image(pointSize: 48)
                let title = "This is a Title"
                let message = "This is a a larger text that should fill the space of the message label component."
                let buttonConfiguration = ButtonConfiguration(title: "Button title", action: {})
                
                beforeEach {
                    sut = StateViewController()
                    sut.view.backgroundColor = .cyan
                    WindowHelper.showInTestWindow(sut)
                }
                
                context("and main state is set") {
                    beforeEach {
                        sut.state = .main
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("StateViewController_Layout_Main_State")
                    }
                }
                
                context("and loading state is set") {
                    beforeEach {
                        sut.state = .loading(title: title, message: message)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut).toEventually(haveValidSnapshot(named: "StateViewController_Layout_Loading_State"), timeout: .milliseconds(100))
                    }
                }
                
                context("and empty state is set") {
                    beforeEach {
                        sut.state = .empty(title: title, message: message, buttonConfiguration: buttonConfiguration)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut).toEventually(haveValidSnapshot(named: "StateViewController_Layout_Empty_State"), timeout: .milliseconds(100))
                    }
                }
                
                context("and error state is set") {
                    beforeEach {
                        sut.state = .error(image: image, title: title, message: message, buttonConfiguration: buttonConfiguration)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut).toEventually(haveValidSnapshot(named: "StateViewController_Layout_Error_State"), timeout: .milliseconds(100))
                    }
                }
            }
        }
    }
}
