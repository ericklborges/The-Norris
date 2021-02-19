//
//  PastQueryCollectionViewCell.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 18/02/21.
//

import UIKit
import Interface

final class PastQueryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    private let termSuggestionView = TermSuggestionView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setup(query: String) {
        clearData()
        termSuggestionView.text = query
    }
    
    private func clearData() {
        termSuggestionView.text = nil
    }
}

// MARK: - Auto Layout

extension PastQueryCollectionViewCell: ViewCodable {
    func setupViewHierarchy() {
        contentView.addSubview(termSuggestionView)
    }
    
    func setupConstraints() {
        termSuggestionView.layout.applyConstraint { make in
            make.constrainEdges(to: contentView)
        }
    }
}
