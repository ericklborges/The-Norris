//
//  TagView.swift
//  Interface
//
//  Created by erick.lozano.borges on 10/02/21.
//

import UIKit

public class TagView: UIView {
    
    // MARK: - Views
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = Font.caption
        label.textColor = Color.Text.highlight
        return label
    }()
    
    // MARK: - Properties
    public var text: String? {
        didSet {
            label.text = text
        }
    }
    
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

// MARK: - Auto Layout

extension TagView: ViewCodable {
    public func setupViewHierarchy() {
        addSubview(label)
    }
    
    public func setupConstraints() {
        label.layout.applyConstraint { make in
            make.leadingAnchor(equalTo: leadingAnchor, constant: 8)
            make.trailingAnchor(equalTo: trailingAnchor, constant: -8)
            make.topAnchor(equalTo: topAnchor, constant: 4)
            make.bottomAnchor(equalTo: bottomAnchor, constant: -4)
        }
    }
    
    public func setupAditionalConfiguration() {
        layer.cornerRadius = 12
        backgroundColor = Color.Background.highlight
    }
}
