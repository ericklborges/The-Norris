//
//  SplashScreenViewModelSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 16/02/21.
//

import Quick
import Nimble

@testable import The_Norris

final class SplashScreenViewModelSpec: QuickSpec {
    override func spec() {
        describe("SplashScreenViewModel") {
            
            var sut: SplashScreenViewModel!
            var apiMock: FactsApiMock!
            var daoMock: CategoriesDAO!
            var delegateSpy: SplashScreenViewModelDelegateSpy!
            
            context("when initialized") {
                beforeEach {
                    apiMock = FactsApiMock()
                    daoMock = CategoriesDAO.make()
                    delegateSpy = SplashScreenViewModelDelegateSpy()
                    sut = SplashScreenViewModel(api: apiMock, categoriesDao: daoMock)
                    sut.delegate = delegateSpy
                }
                
                context("and fetchCategoriesIfNeeded is called") {
                    
                    context("and there are no local categories yet") {
                        
                        context("and it succeeds") {
                            beforeEach {
                                apiMock.shouldFail = false
                                apiMock.fetchCategoriesReturn = ["test1"]
                                sut.fetchCategoriesIfNeeded()
                            }
                            
                            it("should fetch categories") {
                                expect(apiMock.calledFetchCategories) == true
                            }
                            
                            it("should save the received categories in the Database") {
                                expect(daoMock.getAll) == ["test1"]
                            }
                            
                            it("should call delegate's didFinishSetup method") {
                                expect(delegateSpy.calledDidFinishSetup) == true
                            }
                        }
                        
                        context("and it fails") {
                            beforeEach {
                                apiMock.shouldFail = true
                                sut.fetchCategoriesIfNeeded()
                            }
                            
                            it("should fetch categories") {
                                expect(apiMock.calledFetchCategories) == true
                            }
                            
                            it("should not save any categories in the Database") {
                                expect(daoMock.getAll).to(beNil())
                            }
                        }
                    }
                    
                    context("and there are local categories already") {
                        beforeEach {
                            daoMock.create(["test1"])
                            sut.fetchCategoriesIfNeeded()
                        }
                        
                        it("should call delegate's didFinishSetup method") {
                            expect(delegateSpy.calledDidFinishSetup) == true
                        }
                        
                        it("should not fetch categories") {
                            expect(apiMock.calledFetchFacts) == false
                        }
                    }
                }
            }
        }
    }
}
