//
//  SplashScreenViewModelDelegateSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 16/02/21.
//

import Foundation

@testable import The_Norris

final class SplashScreenViewModelDelegateSpy: SplashScreenViewModelDelegate {
    
    private(set) var calledDidFinishSetup: Bool = false
    
    func didFinishSetup() {
        calledDidFinishSetup = true
    }
}
