//
//  MessageViewControllerSpec.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 12/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Interface

class MessageViewControllerSpec: QuickSpec {
    override func spec() {
        
        describe("MessageViewController") {
            
            var sut: MessageViewController!

            context("when initialized") {
                let image = Symbol.wifiSlash.image(pointSize: 48)
                let title = "This is a Title"
                let message = "This is a a larger text that should fill the space of the message label component."
                
                context("with activity indicator") {
                    beforeEach {
                        sut = MessageViewController(image: image, title: title, message: message, shouldShowLoading: true)
                        WindowHelper.showInTestWindow(sut)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("MessageViewController_Layout_Activity_Indicator")
                    }
                }
                
                context("with button configuiration") {
                    beforeEach {
                        let buttonConfiguration = ButtonConfiguration(title: "Try again", action: {})
                        sut = MessageViewController(image: image, title: title, message: message, buttonConfiguration: buttonConfiguration)
                        WindowHelper.showInTestWindow(sut)
                    }
                    
                    it("should layout itself properly") {
                        expect(sut) == snapshot("MessageViewController_Layout_Button_Configuration")
                    }
                }
            }
        }
    }
}
