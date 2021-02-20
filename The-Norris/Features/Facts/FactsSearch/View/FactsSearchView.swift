//
//  FactsSearchView.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 17/02/21.
//

import UIKit
import Interface

protocol FactsSearchViewDelegate: AnyObject {
    func didSelectSuggestion(_ query: String)
    func contentInset() -> UIEdgeInsets
}

final class FactsSearchView: UIView {
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(CategoryCollectionViewCell.self)
        collection.register(PastQueryCollectionViewCell.self)
        collection.registerSectionHeader(FactsSearchSectionHeader.self)
        return collection
    }()
    
    let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 38)
        return flowLayout
    }()
    
    // MARK: - Properties
    private var categories: [String] = []
    private var pastQueries: [String] = []
    weak var delegate: FactsSearchViewDelegate?
    
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
    func setup(categories: [String]) {
        self.categories = categories
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.updateCollectionContentInset()
        }
    }
    
    func setup(pastQueries: [String]) {
        self.pastQueries = pastQueries
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.updateCollectionContentInset()
        }
    }
    
    private func updateCollectionContentInset() {
        guard let contentInset = delegate?.contentInset() else { return }
        collectionView.contentInset = contentInset
        collectionView.scrollIndicatorInsets = contentInset
    }
}

// MARK: - UICollectionViewDataSource

extension FactsSearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch section {
        case .suggestion:
            delegate?.didSelectSuggestion(categories[indexPath.row])
        case .pastQuery:
            delegate?.didSelectSuggestion(pastQueries[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let section = Section(rawValue: section) else { return .zero }
        return section.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let section = Section(rawValue: section) else { return 0.0 }
        return section.minimumSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let section = Section(rawValue: section) else { return 0.0 }
        return section.minimumSpacing
    }
}

// MARK: - UICollectionViewDataSource

extension FactsSearchView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .suggestion:
            return categories.count
        case .pastQuery:
            return pastQueries.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .suggestion:
            let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(category: categories[indexPath.row])
            return cell
        case .pastQuery:
            let cell: PastQueryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setup(query: pastQueries[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader: FactsSearchSectionHeader = collectionView.dequeueReusableSectionHeader(for: indexPath)
        
        guard let section = Section(rawValue: indexPath.section) else {
            sectionHeader.isHidden = true
            return sectionHeader
        }
        
        switch section {
        case .suggestion:
            sectionHeader.isHidden = categories.isEmpty
        case .pastQuery:
            sectionHeader.isHidden = pastQueries.isEmpty
        }
        
        sectionHeader.setup(title: section.title)
        return sectionHeader
    }
}

// MARK: - Auto Layout

extension FactsSearchView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.layout.applyConstraint { make in
            make.constrainEdges(to: self)
        }
    }
    
    func setupAditionalConfiguration() {
        collectionView.backgroundColor = Color.Background.main
    }
}

// MARK: - Section

extension FactsSearchView {
    
    enum Section: Int, CaseIterable {
        case suggestion = 0
        case pastQuery = 1
        
        var title: String {
            switch self {
            case .suggestion:
                return "Suggestions"
            case .pastQuery:
                return "Past searches"
            }
        }
        
        var insets: UIEdgeInsets {
            switch self {
            case .suggestion:
                return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            case .pastQuery:
                return .zero
            }
        }
        
        var minimumSpacing: CGFloat {
            switch self {
            case .suggestion:
                return 8.0
            case .pastQuery:
                return 0.0
            }
        }
    }
}
