//
//  Configuration.swift
//  InterfaceTests
//
//  Created by erick.lozano.borges on 11/02/21.
//

import Quick
import Nimble_Snapshots

class InterfaceTestsConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        
        configuration.beforeSuite {
            setNimbleTestFolder("InterfaceTests")
        }
        
        configuration.afterEach {
            WindowHelper.cleanTestWindow()
        }
    }
}
