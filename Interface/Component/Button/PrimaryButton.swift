//
//  PrimaryButton.swift
//  Interface
//
//  Created by erick.lozano.borges on 12/02/21.
//

import UIKit

final class PrimaryButton: UIButton {
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupLayout()
        setupTitleLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupLayout() {
        layer.cornerRadius = 12
        backgroundColor = Color.Background.highlight
    }
    
    private func setupTitleLabel() {
        titleLabel?.font = Font.header
        setTitleColor(Color.Text.highlight, for: .normal)
        setTitleColor(Color.Text.highlight.withAlphaComponent(0.5), for: .highlighted)
        contentEdgeInsets = UIEdgeInsets(top: 4, left: 28, bottom: 4, right: 28)
    }
}
