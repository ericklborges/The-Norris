//
//  FactDAO.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 20/02/21.
//

import Foundation
import CoreData

protocol FactDAOProtocol {
    @discardableResult func create(_ fact: Fact, for query: String) -> Bool
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
    func create(_ fact: Fact, for query: String) -> Bool {
        let cdFact = CDFact(context: context)
        cdFact.id = fact.id
        cdFact.value = fact.value
        cdFact.categories = Set(fact.categories)
        cdFact.url = fact.url
        cdFact.queries.insert(query)
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func getAll() -> [Fact]? {
        let fetchRequest: NSFetchRequest<CDFact> = CDFact.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { Fact(cdFact: $0) }
        } catch {
            return nil
        }
    }
}
