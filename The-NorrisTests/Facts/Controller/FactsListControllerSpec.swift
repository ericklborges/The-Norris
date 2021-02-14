//
//  FactsListControllerSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import The_Norris

class FactsListControllerSpec: QuickSpec {
    override func spec() {
        describe("FactsListController") {
            
            var sut: FactsListController!
            var navigationMock: UINavigationController!
            
            context("when initialized") {
                
                beforeEach {
                    sut = FactsListController()
                    navigationMock = UINavigationController(rootViewController: sut)
                    navigationMock.applyCustomAppearence()
                    WindowHelper.showInTestWindow(navigationMock)
                }
                
                it("should layout it's navigation properly") {
                    expect(sut.navigationController?.navigationBar) == snapshot("FactsListController_Navigation_Layout")
                }
            }
        }
    }
}
