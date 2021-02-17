//
//  SectionHeaderView.swift
//  Interface
//
//  Created by erick.lozano.borges on 11/02/21.
//

import UIKit

public class SectionHeaderView: UIView {
    
    // MARK: - Views
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = Font.header
        label.textColor = Color.Text.secondary
        return label
    }()
    
    // MARK: - Properties
    public var text: String? {
        didSet { label.text = text }
    }
    
    // MARK: - Life Cycle
    public init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Auto Layout

extension SectionHeaderView: ViewCodable {
    public func setupViewHierarchy() {
        addSubview(label)
    }
    
    public func setupConstraints() {
        label.layout.applyConstraint { make in
            make.topAnchor(equalTo: topAnchor, constant: 8)
            make.bottomAnchor(equalTo: bottomAnchor, constant: -8)
            make.leadingAnchor(equalTo: leadingAnchor, constant: 16)
            make.trailingAnchor(equalTo: trailingAnchor, constant: -16)
        }
    }
    
    public func setupAditionalConfiguration() {
        backgroundColor = Color.Background.sectionHeader
    }
}
