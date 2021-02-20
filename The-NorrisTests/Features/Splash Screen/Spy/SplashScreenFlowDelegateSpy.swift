//
//  SplashScreenFlowDelegateSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 16/02/21.
//

import Foundation

@testable import The_Norris

final class SplashScreenFlowDelegateSpy: SplashScreenFlowDelegate {
    
    private(set) var calledSplashScreenDidFinishSetup: Bool = false
    
    func splashScreenDidFinishSetup(_ controller: SplashScreenViewController) {
        calledSplashScreenDidFinishSetup = true
    }
}
