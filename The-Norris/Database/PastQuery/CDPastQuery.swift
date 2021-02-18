//
//  CDPastQuery.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 18/02/21.
//

import CoreData

final class CDPastQuery: NSManagedObject {
    @NSManaged public var value: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPastQuery> {
        return NSFetchRequest<CDPastQuery>(entityName: "PastQuery")
    }
}
