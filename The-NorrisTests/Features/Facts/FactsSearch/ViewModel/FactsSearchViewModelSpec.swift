//
//  FactsSearchViewModelSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 18/02/21.
//

import Quick
import Nimble

@testable import The_Norris

final class FactsSearchViewModelSpec: QuickSpec {
    override func spec() {
        
        describe("FactsSearchViewModel") {
            
            var sut: FactsSearchViewModel!
            var daoMock: CategoriesDAO!

            context("when initialized") {
                
                beforeEach {
                    daoMock = CategoriesDAO.make()
                    sut = FactsSearchViewModel(categoriesDao: daoMock)
                }
                
                context("and categories are requested") {
                    context("and there are no available categories") {
                        
                        it("should return an empty arrray") {
                            expect(sut.categories.isEmpty) == true
                        }
                    }
                    
                context("and there are categories to return") {
                    
                        beforeEach {
                            daoMock.create(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"])
                        }
                        
                        it("should return a suffled array with 10 itens") {
                            expect(sut.categories.count) == 10
                            expect(sut.categories) != ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
                        }
                    }
                }
            }
        }
    }
}
