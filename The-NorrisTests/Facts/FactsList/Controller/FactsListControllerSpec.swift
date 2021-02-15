//
//  FactsListViewControllerSpec.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import The_Norris

class FactsListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FactsListViewController") {
            
            var sut: FactsListViewController!
            var navigationMock: UINavigationController!
            
            context("when initialized") {
                
                beforeEach {
                    sut = FactsListViewController()
                    navigationMock = UINavigationController(rootViewController: sut)
                    navigationMock.applyCustomAppearence()
                    WindowHelper.showInTestWindow(navigationMock)
                }
                
                it("should layout it's navigation properly") {
                    expect(sut.navigationController?.navigationBar) == snapshot("FactsListViewController_Navigation_Layout")
                }
            }
        }
    }
}
