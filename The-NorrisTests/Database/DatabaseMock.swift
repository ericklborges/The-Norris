//
//  DatabaseMock.swift
//  The-NorrisTests
//
//  Created by erick.lozano.borges on 16/02/21.
//

import CoreData

@testable import The_Norris

final class DatabaseMock {
    
    static let shared = DatabaseMock()
    
    private init() { }
    
    lazy var context: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    lazy var container: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        let appContainer = Database.shared.container
        appContainer.persistentStoreDescriptions = [description]
        return appContainer
    }()
        
    func loadPersistentStores() {
        container.loadPersistentStores { description, error in
            precondition(
                description.type == NSInMemoryStoreType,
                "Failed to create an In Memory Database"
            )
        }
    }

    func clearDatabase() {
        if let stores = context.persistentStoreCoordinator?.persistentStores {
            stores.forEach{ try? context.persistentStoreCoordinator?.remove($0) }
            loadPersistentStores()
        }
    }
}
