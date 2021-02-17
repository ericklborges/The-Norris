//
//  CategoriesDAO.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 16/02/21.
//

import Foundation
import CoreData

protocol CategoriesDAOProtocol {
    @discardableResult func create(_ categories: [String]) -> Bool
    @discardableResult func update(_ categories: [String]) -> Bool
    func getAll() -> [String]?
}

class CategoriesDAO: CategoriesDAOProtocol {
    
    // MARK: - Parameters
    private let context: NSManagedObjectContext
    
    // MARK: - Init
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Create
    static func create() -> CategoriesDAO {
        return CategoriesDAO(Database.shared.context)
    }
    
    // MARK: - Methods
    @discardableResult
    func create(_ categories: [String]) -> Bool {
        let cdCategories = CDCategories(context: context)
        cdCategories.value = Set(categories)
        
        guard getAll() == nil else {
            return update(categories)
        }
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult 
    func update(_ categories: [String]) -> Bool {
        let fetchRequest: NSFetchRequest<CDCategories> = CDCategories.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            results.first?.value = Set(categories)
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func getAll() -> [String]? {
        let fetchRequest: NSFetchRequest<CDCategories> = CDCategories.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            
            return results.first?.value.map { $0 }
        } catch {
            return nil
        }
    }
}
