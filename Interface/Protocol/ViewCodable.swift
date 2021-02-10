//
//  ViewCodable.swift
//  Interface
//
//  Created by erick.lozano.borges on 10/02/21.
//

import Foundation

protocol ViewCodable {
    func setupViews()
    func setupViewHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
}

extension ViewCodable {
    func setupViews() {
        setupViewHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
    
    func setupAditionalConfiguration() { }
}
