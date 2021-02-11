//
//  SeparatorView.swift
//  Interface
//
//  Created by erick.lozano.borges on 11/02/21.
//

import UIKit

class SeparatorView: UIView {
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SeparatorView: ViewCodable {
    func setupViewHierarchy() { }
    
    func setupConstraints() {
        layout.applyConstraint { make in
            make.heightAnchor(equalTo: 0.5)
        }
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = Color.Background.separator
    }
}
