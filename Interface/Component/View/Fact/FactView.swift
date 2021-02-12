//
//  FactView.swift
//  Interface
//
//  Created by erick.lozano.borges on 11/02/21.
//

import UIKit

class FactView: UIView {
    
    // MARK: - Views
    private let factLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textColor = Color.Text.primary
        return label
    }()
    
    private let categoryView = TagView()
    
    private let shareButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(Symbol.squareAndArrowUp.image(), for: .normal)
        button.imageView?.tintColor = Color.Background.highlight
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    public var buttonAction: (() -> Void)?
    
    public var factText: String? {
        didSet {
            setFact(factText)
        }
    }
    
    public var categoryText: String? {
        didSet {
            categoryView.text = categoryText
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
    
    // MARK: - Setup
    private func setFact(_ text: String?) {
        guard let text = text else {
            factLabel.text = nil
            return
        }
        
        factLabel.font = text.count > 80 ? Font.body : Font.highlight
        factLabel.text = text
    }
    
    // MARK: - Actions
    @objc
    private func buttonTap() {
        buttonAction?()
    }
}

// MARK: - Auto Layout

extension FactView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(factLabel)
        addSubview(categoryView)
        addSubview(shareButton)
    }
    
    func setupConstraints() {
        factLabel.layout.applyConstraint { make in
            make.topAnchor(equalTo: topAnchor, constant: 16)
            make.leadingAnchor(equalTo: leadingAnchor, constant: 16)
            make.trailingAnchor(equalTo: trailingAnchor, constant: -16)
        }
        
        categoryView.layout.applyConstraint { make in
            make.topAnchor(equalTo: factLabel.bottomAnchor, constant: 12)
            make.bottomAnchor(equalTo: bottomAnchor, constant: -16)
            make.leadingAnchor(equalTo: leadingAnchor, constant: 16)
        }
        
        shareButton.layout.applyConstraint { make in
            make.widthAnchor(equalTo: 40)
            make.heightAnchor(equalTo: 40)
            make.trailingAnchor(equalTo: trailingAnchor, constant: -8)
            make.centerYAnchor(equalTo: categoryView.centerYAnchor)
        }
    }
    
    func setupAditionalConfiguration() {
        layer.cornerRadius = 12.0
        backgroundColor = Color.Background.main
    }
}
