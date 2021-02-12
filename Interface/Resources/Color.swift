//
//  Colors.swift
//  Interface
//
//  Created by erick.lozano.borges on 10/02/21.
//

import UIKit

public enum Color {
    public enum Background {
        public static let main = UIColor(255, 255, 255)
        public static let separator = UIColor(198, 198, 200)
        public static let highlight = UIColor(10, 116, 255)
        public static let sectionHeader = UIColor(242, 242, 247)
    }
    
    public enum Text {
        public static let primary = UIColor(0, 0, 0)
        public static let secondary = UIColor(116, 116, 116)
        public static let highlight = UIColor(255, 255, 255)
    }
    
    public enum Shadow {
        public static let alpha10 = UIColor(0, 0, 0, 0.1)
    }
}
