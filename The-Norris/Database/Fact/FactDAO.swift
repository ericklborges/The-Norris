//
//  FactDAO.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 20/02/21.
//

import Foundation
import CoreData

protocol FactDAOProtocol {
    @discardableResult func create(_ facts: [Fact], for query: String) -> Bool
    func getAll(for query: String) -> [Fact]?
    func getAll() -> [Fact]?
}

final class FactDAO: FactDAOProtocol {
    
    // MARK: - Parameters
    private let context: NSManagedObjectContext
    
    // MARK: - Init
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Make
    static func make() -> FactDAO {
        return FactDAO(Database.shared.context)
    }
    
    // MARK: - Methods
    
    @discardableResult
    func create(_ facts: [Fact], for query: String) -> Bool {
        
        facts.forEach { fact in
            let cdFact = CDFact(context: context)
            cdFact.id = fact.id
            cdFact.value = fact.value
            cdFact.categories = Set(fact.categories)
            cdFact.url = fact.url
            cdFact.queries.insert(query)
        }
        
        do {
            try context.save()
            return true
        } catch let error {
            print("[debug] error: \(error)")
            return false
        }
    }
    
    func getAll(for query: String) -> [Fact]? {
        let fetchRequest: NSFetchRequest<CDFact> = CDFact.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            let filtedResults = results.filter { $0.queries.contains(query) }
            guard !filtedResults.isEmpty else { return nil }
            return filtedResults.map { Fact(cdFact: $0) }
        } catch {
            return nil
        }
    }
    
    func getAll() -> [Fact]? {
        let fetchRequest: NSFetchRequest<CDFact> = CDFact.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            guard !results.isEmpty else { return nil }
            return results.map { Fact(cdFact: $0) }
        } catch {
            return nil
        }
    }
}
