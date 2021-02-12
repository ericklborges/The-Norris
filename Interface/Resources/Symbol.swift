//
//  Symbol.swift
//  Interface
//
//  Created by erick.lozano.borges on 10/02/21.
//

import UIKit

public enum Symbol: String {
    case arrowUpBackward = "arrow.up.backward"
    case clockArrowCirclepath = "clock.arrow.circlepath"
    case magnifyingglass = "magnifyingglass"
    case pencilSlash = "pencil.slash"
    case squareAndArrowUp = "square.and.arrow.up"
    case wifiSlash = "wifi.slash"
    
    public func image(pointSize: CGFloat = 17.0, weight: UIImage.SymbolWeight = .regular, scale: UIImage.SymbolScale = .default) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        guard let image = UIImage(systemName: rawValue, withConfiguration: configuration) else {
            preconditionFailure("Could not load Symbol called: \(rawValue), with configuration: \(configuration)")
        }
        return image
    }
}
