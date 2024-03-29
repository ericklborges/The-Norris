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

final class MessageViewSpec: QuickSpec {
    override func spec() {
        
        describe("MessageView") {
            
            var sut: MessageView!

            context("when initialized") {
                let title = "This is a Title"
                let message = "This is a a larger text that should fill the space of the message label component."
                
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
                            sut.title = title
                            sut.message = message
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
                            sut.title = title
                            sut.message = message
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
