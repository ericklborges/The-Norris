//
//  CategoryCollectionViewCell.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 17/02/21.
//

import UIKit
import Interface

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    private let tagView = TagView()
    
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
    func setup(category: String) {
        clearData()
        tagView.text = category
    }
    
    private func clearData() {
        tagView.text = nil
    }
}

// MARK: - Auto Layout

extension CategoryCollectionViewCell: ViewCodable {
    func setupViewHierarchy() {
        contentView.addSubview(tagView)
    }
    
    func setupConstraints() {
        tagView.layout.applyConstraint { make in
            make.constrainEdges(to: contentView)
        }
    }
}
