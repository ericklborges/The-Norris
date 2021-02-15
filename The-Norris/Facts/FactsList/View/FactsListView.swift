//
//  FactsListView.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

class FactsListView: UIView {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(FactTableViewCell.self)
        return tableView
    }()
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupViews()
        tableView.reloadData()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UITableViewDataSource

extension FactsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsStub.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FactTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(fact: factsStub[indexPath.row])
        return cell
    }
}

// MARK: Auto Layout

extension FactsListView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.layout.applyConstraint { make in
            make.constrainEdges(to: self)
        }
    }
    
    public func setupAditionalConfiguration() {
        backgroundColor = Color.Background.main
    }
}
