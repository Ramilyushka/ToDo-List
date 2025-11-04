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
    private let checkBox = CheckboxButton()
    
    private let innerContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel = UILabel(font: .button)
    private let descriptionLabel = UILabel(font: .caption)
    private let dateLabel = UILabel(font: .caption, opacity: 0.5)
    
    // MARK: - Init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupViews() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = Constants.cornerRadius
        [titleLabel, descriptionLabel, dateLabel].forEach {
            innerContentStack.addArrangedSubview($0)
        }
        contentView.addSubview(checkBox)
        contentView.addSubview(innerContentStack)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkBox.heightAnchor.constraint(equalToConstant: Constants.checkboxHeight),
            checkBox.widthAnchor.constraint(equalToConstant: Constants.checkboxWidth),
            checkBox.topAnchor.constraint(equalTo: contentView.topAnchor),
            checkBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
            innerContentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalPadding),
            innerContentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalPadding),
            innerContentStack.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: Constants.contentSpacing),
            innerContentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding)
        ])
    }
    
    // MARK: - Public methods
    public func update(with todo: TodoEntity) {
        titleLabel.text = todo.title
        descriptionLabel.text = todo.description
        dateLabel.text = todo.date.shortFormat
        checkBox.isSelected = todo.completed
    }
}

// MARK: - Extension: Constants
private extension TodoCell {
    enum Constants {
        static let cornerRadius: CGFloat = 8
        static let spacing: CGFloat = 6
        static let contentSpacing: CGFloat = 8
        static let verticalPadding: CGFloat = 12
        static let horizontalPadding: CGFloat = 20
        static let checkboxHeight: CGFloat = 48
        static let checkboxWidth: CGFloat = 24
    }
}
