//
//  NSDate+Comparable.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 18/02/21.
//

import Foundation

extension NSDate: Comparable {
    
    public static func > (lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.compare(rhs as Date) == ComparisonResult.orderedDescending
    }
    
    public static func < (lhs: NSDate, rhs: NSDate) -> Bool {
        return lhs.compare(rhs as Date) == ComparisonResult.orderedAscending
    }
}
