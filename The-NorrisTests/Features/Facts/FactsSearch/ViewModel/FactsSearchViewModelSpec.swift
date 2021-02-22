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
            var categoriesDaoMock: CategoriesDAO!
            var pastQueryDaoMock: PastQueryDAO!
            
            context("when initialized") {
                
                beforeEach {
                    categoriesDaoMock = CategoriesDAO.make()
                    pastQueryDaoMock = PastQueryDAO.make()
                    sut = FactsSearchViewModel(
                        categoriesDao: categoriesDaoMock,
                        pastQueryDao: pastQueryDaoMock
                    )
                }
                
                context("and categories are requested") {
                    
                    context("and there are no available categories") {
                        
                        it("should return an empty arrray") {
                            expect(sut.categories.isEmpty) == true
                        }
                    }
                    
                    context("and there are categories to return") {
                        
                        beforeEach {
                            categoriesDaoMock.create(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"])
                        }
                        
                        it("should return a suffled array with 10 itens") {
                            expect(sut.categories.count) == 8
                            expect(sut.categories) != ["1", "2", "3", "4", "5", "6", "7", "8"]
                        }
                    }
                }
                
                context("and pastQuerie is saved") {
                    beforeEach {
                        sut.save(query: "pastQuery1")
                    }
                    
                    it("should return saved query") {
                        expect(sut.pastQueries.count) == 1
                        expect(sut.pastQueries) == ["pastQuery1"]
                    }
                }
                
                context("and pastQueries are requested") {
                    
                    context("and there are no available pastQueries") {
                        
                        it("should return an empty arrray") {
                            expect(sut.pastQueries.isEmpty) == true
                        }
                    }
                    
                    context("and there are pastQueries to return") {
                        
                        beforeEach {
                            pastQueryDaoMock.create("pastQuery1")
                            pastQueryDaoMock.create("pastQuery2")
                        }

                        it("should return all created queries") {
                            expect(sut.pastQueries.count) == 2
                            expect(sut.pastQueries) == ["pastQuery2", "pastQuery1"]
                        }
                    }
                }
            }
        }
    }
}
