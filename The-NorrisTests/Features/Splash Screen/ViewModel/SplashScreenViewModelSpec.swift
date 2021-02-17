//
//  SplashScreenViewModelSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 16/02/21.
//

import Quick
import Nimble

@testable import The_Norris

class SplashScreenViewModelSpec: QuickSpec {
    override func spec() {
        describe("SplashScreenViewModel") {
            
            var sut: SplashScreenViewModel!
            var apiMock: FactsApiMock!
            var daoSpy: CategoriesDaoSpy!
            var delegateSpy: SplashScreenViewModelDelegateSpy!
            
            context("when initialized") {
                beforeEach {
                    apiMock = FactsApiMock()
                    daoSpy = CategoriesDaoSpy()
                    delegateSpy = SplashScreenViewModelDelegateSpy()
                    sut = SplashScreenViewModel(api: apiMock, categoriesDao: daoSpy)
                    sut.delegate = delegateSpy
                }
                
                context("and it fetchCategories") {
                    
                    context("and it suceeds") {
                        beforeEach {
                            apiMock.shouldFail = false
                            sut.fetchCategories()
                        }
                        
                        it("should save the received categories in the Database") {
                            expect(daoSpy.calledCreate) == true
                        }
                        
                        it("should call delegate's didFinishSetup method") {
                            expect(delegateSpy.calledDidFinishSetup) == true
                        }
                    }
                    
                    context("and it fails") {
                        beforeEach {
                            apiMock.shouldFail = true
                            sut.fetchCategories()
                        }
                        
                        it("should call delegate's didFinishSetup method") {
                            expect(delegateSpy.calledDidFinishSetup) == false
                        }
                    }
                }
            }
        }
    }
}
