//
//  FactTableViewCell.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

protocol FactTableViewCellActionDelegate: AnyObject {
    func factCell(_ cell: FactTableViewCell, buttonTappedWith fact: Fact)
}

final class FactTableViewCell: UITableViewCell {
    
    // MARK: - Views
    private let factView = FactView()
    
    // MARK: - Property
    private var fact: Fact?
    weak var actionDelegate: FactTableViewCellActionDelegate?
    
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
        self.fact = fact
        factView.factText = fact.value
        factView.categoryText = fact.categories.first ?? L10n.FactsList.Fact.defaultCategory
        
        factView.buttonAction = { [weak self] in
            guard let self = self else { return }
            self.actionDelegate?.factCell(self, buttonTappedWith: fact)
        }
    }
    
    private func clearData() {
        self.fact = nil
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
