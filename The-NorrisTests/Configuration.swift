//
//  Configuration.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 14/02/21.
//

import Quick
import Nimble_Snapshots

class The_NorrisTestsConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        
        configuration.beforeSuite {
            setNimbleTestFolder("The-NorrisTests")
        }
        
        configuration.afterEach {
            WindowHelper.cleanTestWindow()
        }
    }
}
