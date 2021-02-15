//
//  FactsListView.swift
//  The-Norris
//
//  Created by erick.lozano.borges on 14/02/21.
//

import UIKit
import Interface

protocol FactsListViewShareDelegate: AnyObject {
    func factsList(_ view: FactsListView, wantsToShare fact: Fact)
}

class FactsListView: UIView {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FactTableViewCell.self)
        return tableView
    }()
    
    // MARK: - Properties
    private var facts: [Fact] = []
    weak var shareDelegate: FactsListViewShareDelegate?
    
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
    
    // MARK: - Setup
    func setup(facts: [Fact]) {
        self.facts = facts
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension FactsListView: FactTableViewCellActionDelegate {
    func factCell(_ cell: FactTableViewCell, buttonTappedWith fact: Fact) {
        shareDelegate?.factsList(self, wantsToShare: fact)
    }
}

// MARK: - UITableViewDataSource

extension FactsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FactTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.actionDelegate = self
        cell.setup(fact: facts[indexPath.row])
        return cell
    }
}

// MARK: - Auto Layout

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
