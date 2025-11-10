//
//  TaskCell.swift
//  ToDo-List
//
//  Created by Ramilia on 02/11/25.
//

import UIKit

final class TodoCell: UITableViewCell, ReuseIdentifying {
    
    static let identifier: String = "TaskCell"
    
    // MARK: - UI properties
    private let todoView = TodoView(state: .content(.empty))
    
    // MARK: - Init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        todoView.prepareForReuse()
    }
    
    // MARK: - Private methods
    private func setupSubViews() {
        backgroundColor = .clear
        contentView.addSubview(todoView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            todoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            todoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            todoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            todoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    // MARK: - Public methods
    public func update(with todo: TodoViewModel) {
        todoView.prepare(
            with: .content(todo)
        )
    }
}
