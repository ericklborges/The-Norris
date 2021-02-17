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
}

class FactsSearchView: UIView {
    
    // MARK: - Views
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.register(CategoryCollectionViewCell.self)
        collection.registerSectionHeader(FactsSearchSectionHeader.self)
        return collection
    }()
    
    let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8.0
        flowLayout.minimumInteritemSpacing = 8.0
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 38)
        return flowLayout
    }()
    
    // MARK: - Properties
    private var categories: [String] = []
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
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FactsSearchView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectSuggestion(categories[indexPath.row])
    }
}

// MARK: - UICollectionViewDataSource

extension FactsSearchView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(category: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let sectionHeader: FactsSearchSectionHeader = collectionView.dequeueReusableSectionHeader(for: indexPath)
        sectionHeader.setup(title: "Suggestions")
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
