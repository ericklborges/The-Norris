//
//  PastQueryDAO.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 18/02/21.
//

import Foundation
import CoreData

protocol PastQueryDAOProtocol {
    @discardableResult func create(_ query: String) -> Bool
    func getAll() -> [String]?
}

final class PastQueryDAO: PastQueryDAOProtocol {
    
    // MARK: - Parameters
    private let context: NSManagedObjectContext
    
    // MARK: - Init
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Make
    static func make() -> PastQueryDAO {
        return PastQueryDAO(Database.shared.context)
    }
    
    // MARK: - Methods
    @discardableResult
    func create(_ query: String) -> Bool {
        let cdPastQuery = CDPastQuery(context: context)
        cdPastQuery.value = query
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func getAll() -> [String]? {
        let fetchRequest: NSFetchRequest<CDPastQuery> = CDPastQuery.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            
            return results
                .sorted { $0.creationDate > $1.creationDate }
                .compactMap { $0.value }
        } catch {
            return nil
        }
    }
}
