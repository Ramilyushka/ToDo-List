//
//  TaskCell.swift
//  ToDo-List
//
//  Created by Ramilia on 02/11/25.
//

import UIKit

final class TaskCell: UITableViewCell, ReuseIdentifying {
    
    static let identifier: String = "TaskCell"
    
    // MARK: - UI properties
    private let stackView: UIStackView = {
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
      //  contentView.removeFromSuperview()
        
        [titleLabel, descriptionLabel, dateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalPadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalPadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalPadding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalPadding)
        ])
    }
    
    // MARK: - Public methods
    public func update(with viewModel: TaskModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date.formatted()
    }
}

// MARK: - Extension: Constants
private extension TaskCell {
    enum Constants {
        static let spacing: CGFloat = 6
        static let verticalPadding: CGFloat = 20
        static let horizontalPadding: CGFloat = 0
    }
}
