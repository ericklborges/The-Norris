//
//  CategoriesDaoSpy.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 16/02/21.
//

import Foundation

@testable import The_Norris

class CategoriesDaoSpy: CategoriesDAOProtocol {
    
    private(set) var calledCreate: Bool = false
    private(set) var calledUpdate: Bool = false
    private(set) var calledGetAll: Bool = false
    
    func create(_ categories: [String]) -> Bool {
        calledCreate = true
        return true
    }
    
    func update(_ categories: [String]) -> Bool {
        calledUpdate = true
        return true
    }
    
    func getAll() -> [String]? {
        calledGetAll = true
        return nil
    }
}
