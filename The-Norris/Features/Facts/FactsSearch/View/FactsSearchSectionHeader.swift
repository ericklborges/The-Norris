//
//  FactsSearchSectionHeader.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 17/02/21.
//

import UIKit
import Interface

final class FactsSearchSectionHeader: UICollectionReusableView {
    
    // MARK: - Views
    let sectionHeaderView = SectionHeaderView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setup(title: String) {
        clearData()
        sectionHeaderView.text = title
    }
    
    func clearData() {
        sectionHeaderView.text = nil
    }
}

// MARK: - Auto Layout

extension FactsSearchSectionHeader: ViewCodable {
    func setupViewHierarchy() {
        addSubview(sectionHeaderView)
    }
    
    func setupConstraints() {
        sectionHeaderView.layout.applyConstraint { make in
            make.constrainEdges(to: self)
        }
    }
}
