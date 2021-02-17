//
//  Configuration.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Quick
import Nimble_Snapshots

@testable import The_Norris

class The_NorrisTestsConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        
        configuration.beforeSuite {
            setNimbleTestFolder("The-NorrisTests")
            DatabaseMock.shared.loadPersistentStores()
            Database.shared.testsContext = { DatabaseMock.shared.context }
        }
        
        configuration.afterEach {
            DatabaseMock.shared.clearDatabase()
            WindowHelper.cleanTestWindow()
        }
    }
}
