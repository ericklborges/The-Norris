//
//  Colors.swift
//  Interface
//
//  Created by erick.lozano.borges on 10/02/21.
//

import UIKit

public enum Color {
    public enum Background {
        public static let main = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        public static let separator = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1)
        public static let sectionHeader = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        public static let sectionHighlight = UIColor(red: 0.04, green: 0.52, blue: 1, alpha: 1)
    }
    
    public enum Text {
        public static let primary = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        public static let secondary = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)
        public static let highlight = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    public enum Shadow {
        public static let alpha10 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    }
}
