//
//  FactTableViewCell.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

class FactTableViewCell: UITableViewCell {
    
    // MARK: - Views
    private let factView = FactView()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        factView.applyShadow(color: Color.Shadow.alpha10, opacity: 0.8, blur: 25, spread: 2.5)
    }
    
    // MARK: - Setup
    func setup(fact: Fact) {
        clearData()
        factView.factText = fact.value
        factView.categoryText = fact.categories.first ?? "Uncategorized"
    }
    
    private func clearData() {
        factView.factText = nil
        factView.categoryText = nil
        factView.buttonAction = nil
    }
}

// MARK: - Auto Layout

extension FactTableViewCell: ViewCodable {
    func setupViewHierarchy() {
        contentView.addSubview(factView)
    }
    
    func setupConstraints() {
        factView.layout.applyConstraint { make in
            make.topAnchor(equalTo: contentView.topAnchor, constant: 16)
            make.bottomAnchor(equalTo: contentView.bottomAnchor, constant: -16)
            make.leadingAnchor(equalTo: contentView.leadingAnchor, constant: 16)
            make.trailingAnchor(equalTo: contentView.trailingAnchor, constant: -16)
        }
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
