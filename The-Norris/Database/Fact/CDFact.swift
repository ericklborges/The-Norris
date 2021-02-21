//
//  CDFact.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 20/02/21.
//

import CoreData

final class CDFact: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var value: String
    @NSManaged public var categories: Set<String>
    @NSManaged public var url: String
    @NSManaged public var queries: Set<String>
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFact> {
        return NSFetchRequest<CDFact>(entityName: "Fact")
    }
}
