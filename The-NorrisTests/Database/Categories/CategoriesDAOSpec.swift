//
//  CategoriesDAOSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 16/02/21.
//

import Quick
import Nimble

@testable import The_Norris

final class CategoriesDAOSpec: QuickSpec {
    override func spec() {
        
        describe("CategoriesDAO") {
            
            var sut: CategoriesDAO!
            
            context("when initialized") {

                beforeEach {
                    sut = CategoriesDAO.make()
                }
                
                context("and categories are created") {
                    
                    context("and there are categories persisted") {
                        beforeEach {
                            sut.create(["test1", "test2"])
                            sut.create(["updated"])
                        }

                        it("should update") {
                            expect(sut.getAll()?.count) == 1
                            expect(sut.getAll()?.first) == "updated"
                        }
                    }

                    context("without categories persisted") {
                        
                        it("should create") {
                            expect(sut.create(["test1", "test2"])) == true
                            expect(sut.getAll()?.count) == 2
                        }
                    }
                }
                
                context("and categories are updated") {
                    
                    context("and there are categories persisted") {
                        beforeEach {
                            sut.create(["test1", "test2"])
                        }

                        it("should update") {
                            expect(sut.update(["updated"])) == true
                            expect(sut.getAll()?.count) == 1
                            expect(sut.getAll()?.first) == "updated"
                        }
                    }

                    context("without categories persisted") {
                        it("should return nil") {
                            expect(sut.update(["test1", "test2"])) == false
                            expect(sut.getAll()?.count).to(beNil())
                        }
                    }
                }
                
                context("and all categories are request") {
                    context("and there are categories persisted") {
                        beforeEach {
                            sut.create(["test1", "test2"])
                        }

                        it("should return categories") {
                            expect(sut.getAll()?.count) == 2
                        }
                    }

                    context("without categories persisted") {
                        it("should return nil") {
                            expect(sut.getAll()).to(beNil())
                        }
                    }
                }
            }
        }
    }
}
