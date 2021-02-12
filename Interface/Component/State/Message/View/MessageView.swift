//
//  MessageView.swift
//  Interface
//
//  Created by erick.lozano.borges on 12/02/21.
//

import UIKit

class MessageView: UIView {
    
    typealias ButtonConfiguration = (title: String, action: () -> Void)
    
    // MARK: - Views
    private let stackView: UIStackView = {
        var stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.isHidden = true
        image.tintColor = Color.Text.primary
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.isHidden = true
        label.numberOfLines = 0
        label.font = Font.title
        label.textColor = Color.Text.primary
        label.textAlignment = .center
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.isHidden = true
        label.numberOfLines = 0
        label.font = Font.body
        label.textColor = Color.Text.secondary
        label.textAlignment = .center
        return label
    }()
    
    private let button: PrimaryButton = {
        let button = PrimaryButton()
        button.isHidden = true
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        return activityIndicator
    }()

    // MARK: - Parameters
    var image: UIImage? {
        didSet { setImage(image) }
    }
    
    var title: String? {
        didSet { setText(title, to: titleLabel) }
    }
    
    var message: String? {
        didSet { setText(message, to: messageLabel) }
    }
    
    var buttonConfiguration: ButtonConfiguration? {
        didSet { didSet(buttonConfiguration) }
    }
    
    var shouldShowLoading: Bool = false {
        didSet { activityIndicator.isHidden = !shouldShowLoading }
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
    private func setImage(_ image: UIImage?) {
        guard let newImage = image else {
            imageView.image = nil
            imageView.isHidden = true
            return
        }
        
        imageView.image = newImage
        imageView.isHidden = false
    }
    
    private func setText(_ text: String?, to label: UILabel) {
        guard let newText = text, !newText.isEmpty else {
            label.text = nil
            label.isHidden = true
            return
        }
        
        label.text = newText
        label.isHidden = false
    }
    
    private func didSet(_ configuration: ButtonConfiguration?) {
        guard
            let newConfiguration = configuration,
            !newConfiguration.title.isEmpty
        else {
            button.setTitle(nil, for: .normal)
            button.isHidden = true
            return
        }
        
        button.setTitle(configuration?.title, for: .normal)
        button.isHidden = false
    }
    
    // MARK: - Actions
    @objc
    private func buttonTap() {
        buttonConfiguration?.action()
    }
}

// MARK: Auto Layout

extension MessageView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(activityIndicator)
    }
    
    func setupConstraints() {
        stackView.setCustomSpacing(16, after: imageView)
        stackView.setCustomSpacing(4, after: titleLabel)
        stackView.setCustomSpacing(32, after: messageLabel)
        
        stackView.layout.applyConstraint { make in
            make.centerXAnchor(equalTo: centerXAnchor)
            make.centerYAnchor(equalTo: centerYAnchor)
            make.leadingAnchor(equalTo: leadingAnchor, constant: 64)
            make.trailingAnchor(equalTo: trailingAnchor, constant: -64)
        }
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = Color.Background.main
    }
}
