//
//  Database.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 16/02/21.
//

import CoreData

class Database {
    
    static let shared = Database()
    
    private init() { }
    
    var testsContext: () -> NSManagedObjectContext = { Database.shared.context }
    
    var context: NSManagedObjectContext {
        #if TESTS
        return testsContext()
        #else
        return container.viewContext
        #endif
    }
    
    lazy var container: NSPersistentContainer = {
        let bundle = Bundle(for: Database.self)
        guard
            let path = bundle.path(forResource: "Database", ofType: "momd"),
            let url = URL(string: path),
            let dataModel = NSManagedObjectModel(contentsOf: url)
        else {
            preconditionFailure("Failed to load database")
        }
        return NSPersistentContainer(name: "Database.xcdatamodeld", managedObjectModel: dataModel)
    }()
    
    func loadPersistentStores() {
        container.loadPersistentStores { description, error in
            guard let error = error else { return }
            preconditionFailure("Failed to load database with error: \(String(describing: error)), \(description)")
        }
    }
}
