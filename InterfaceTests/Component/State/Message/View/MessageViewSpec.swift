//
//  MessageViewSpec.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 12/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Interface

class MessageViewSpec: QuickSpec {
    override func spec() {
        
        describe("MessageView") {
            
            var sut: MessageView!

            context("when initialized") {
                beforeEach {
                    sut = MessageView()
                    sut.frame.size = CGSize(width: 375.0, height: 242.0)
                }
                
                context("and buttonConfiguraton is set") {
                    beforeEach {
                        sut.buttonConfiguration = (title: "Button Title", action: {})
                    }
                    
                    context("plus title and message") {
                        beforeEach {
                            sut.title = "This is a Title"
                            sut.message = "This is a a larger text that should fill the space of the message label component."
                        }
                        
                        it("should layout itself properly") {
                            expect(sut) == snapshot("MessageView_Title_Message_Button")
                        }
                        
                        context("plus image") {
                            beforeEach {
                                sut.image = Symbol.wifiSlash.image(pointSize: 48.0)
                            }
                            
                            it("should layout itself properly") {
                                expect(sut) == snapshot("MessageView_Image_Title_Message_Button")
                            }
                        }
                    }
                }
                
                context("and loading is set") {
                    beforeEach {
                        sut.shouldShowLoading = true
                    }
                    
                    context("plus title and message") {
                        beforeEach {
                            sut.title = "This is a Title"
                            sut.message = "This is a a larger text that should fill the space of the message label component."
                        }
                        
                        it("should layout itself properly") {
                            expect(sut) == snapshot("MessageView_Title_Message_Loading")
                        }
                        
                        context("plus image") {
                            beforeEach {
                                sut.image = Symbol.wifiSlash.image(pointSize: 48.0)
                            }
                            
                            it("should layout itself properly") {
                                expect(sut) == snapshot("MessageView_Image_Title_Message_Loading")
                            }
                        }
                    }
                }
            }
        }
    }
}
