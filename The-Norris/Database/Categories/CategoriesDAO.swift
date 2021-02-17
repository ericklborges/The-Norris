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
    
    // MARK: - Make
    static func make() -> CategoriesDAO {
        return CategoriesDAO(Database.shared.context)
    }
    
    // MARK: - Methods
    @discardableResult
    func create(_ categories: [String]) -> Bool {
        guard getAll() == nil else {
            return update(categories)
        }
        
        let cdCategories = CDCategories(context: context)
        cdCategories.value = Set(categories)
        
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
            guard let previousCategories = results.first else {
                return false
            }
            
            previousCategories.value = Set(categories)
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
            guard let categories = results.first else {
                return nil
            }
            
            return categories.value.compactMap { $0 }
        } catch {
            return nil
        }
    }
}
