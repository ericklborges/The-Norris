//
//  CDCategories.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 16/02/21.
//

import CoreData

final class CDCategories: NSManagedObject {
    @NSManaged public var value: Set<String>
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategories> {
        return NSFetchRequest<CDCategories>(entityName: "Categories")
    }
}
