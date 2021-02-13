//
//  TermSuggestionView.swift
//  Interface
//
//  Created by erick.lozano.borges on 11/02/21.
//

import UIKit

class TermSuggestionView: UIView {
    
    // MARK: - Views
    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = Font.body
        label.textColor = Color.Text.primary
        return label
    }()
    
    private let arrowIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = Symbol.arrowUpBackward.image()
        imageView.tintColor = Color.Background.highlight
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private let separatorView = SeparatorView()
    
    private let separatorOffsetView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    private let separatorStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 0
        stackView.axis = .horizontal
        return stackView
    }()
    
    // MARK: - Properties
    public var text: String? {
        didSet { label.text = text }
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
    func setFullWidthSeparator() {
        separatorOffsetView.isHidden = true
    }
    
    func setOffsetSeparator() {
        separatorOffsetView.isHidden = false
    }
}

// MARK: - Auto Layout

extension TermSuggestionView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(label)
        addSubview(arrowIcon)
        
        addSubview(separatorStack)
        separatorStack.addArrangedSubview(separatorOffsetView)
        separatorStack.addArrangedSubview(separatorView)
    }
    
    func setupConstraints() {
        label.layout.applyConstraint { make in
            make.topAnchor(equalTo: topAnchor, constant: 12)
            make.bottomAnchor(equalTo: bottomAnchor, constant: -12)
            make.leadingAnchor(equalTo: leadingAnchor, constant: 16)
        }
        
        arrowIcon.layout.applyConstraint { make in
            make.widthAnchor(equalTo: 20)
            make.heightAnchor(equalTo: 20)
            make.leadingAnchor(equalTo: label.trailingAnchor, constant: 8)
            make.trailingAnchor(equalTo: trailingAnchor, constant: -16)
            make.centerYAnchor(equalTo: centerYAnchor)
        }
        
        separatorOffsetView.layout.applyConstraint { make in
            make.widthAnchor(equalTo: 16)
            make.heightAnchor(equalTo: 0.5)
        }
        
        separatorStack.layout.applyConstraint { make in
            make.bottomAnchor(equalTo: bottomAnchor)
            make.leadingAnchor(equalTo: leadingAnchor)
            make.trailingAnchor(equalTo: trailingAnchor)
        }
    }
    
    public func setupAditionalConfiguration() {
        backgroundColor = Color.Background.main
    }
}
