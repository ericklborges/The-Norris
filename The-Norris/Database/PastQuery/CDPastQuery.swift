//
//  CDPastQuery.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 18/02/21.
//

import CoreData

final class CDPastQuery: NSManagedObject {
    @NSManaged public var value: String
    @NSManaged public var creationDate: NSDate
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPastQuery> {
        return NSFetchRequest<CDPastQuery>(entityName: "PastQuery")
    }
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = NSDate()
    }
}
