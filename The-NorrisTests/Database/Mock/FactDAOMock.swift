//
//  FactDAOMock.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 21/02/21.
//

@testable import The_Norris

class FactDAOMock: FactDAOProtocol {
    
    private(set) var calledCreate: Bool = false
    private(set) var calledGetAllForQuery: Bool = false
    private(set) var calledGetAll: Bool = false

    private let dao = FactDAO.make()
    var passedQuery: String?
    
    @discardableResult
    func create(_ facts: [Fact], for query: String) -> Bool {
        calledCreate = true
        passedQuery = query
        return dao.create(facts, for: query)
    }
    
    func getAll(for query: String) -> [Fact]? {
        calledGetAllForQuery = true
        return dao.getAll(for: query)
    }
    
    func getAll() -> [Fact]? {
        calledGetAll = true
        return dao.getAll()
    }
}
