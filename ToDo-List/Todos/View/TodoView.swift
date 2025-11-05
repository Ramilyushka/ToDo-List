//
//  TodoView.swift
//  ToDo-List
//
//  Created by Ramilia on 05/11/25.
//
import UIKit

extension TodoView {
    public enum State {
        case loading
        case content(TodoViewModel)
        
        public static let empty = State.content(
            .init(id: UUID(), title: "empty", todo: "empty", date: Date.distantPast, completed: false)
        )
    }
}

final class TodoView: BaseView {
    // MARK: - Properties
    private var state: State
    private var action: (()-> Void)? = nil
    
    // MARK: - UI Properties
    private lazy var checkBox = CheckboxButton()
    private let innerContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let titleLabel = UILabel(font: .button)
    private let todoLabel = UILabel(font: .caption)
    private let dateLabel = UILabel(font: .caption, opacity: Constants.opacity)
    
    // MARK: - Init
    init(state: State, action: (()-> Void)? = nil) {
        self.state = state
        self.action = action
        super.init()
    }
    
    override func setupSubViews() {
        backgroundColor = .clear
        layer.cornerRadius = Constants.cornerRadius
        
        addSubview(checkBox)
        addSubview(innerContentStack)
        innerContentStack.addArrangedSubview(titleLabel)
        innerContentStack.addArrangedSubview(todoLabel)
        innerContentStack.addArrangedSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            checkBox.heightAnchor.constraint(equalToConstant: Constants.checkboxHeight),
            checkBox.widthAnchor.constraint(equalToConstant: Constants.checkboxWidth),
            checkBox.topAnchor.constraint(equalTo: topAnchor),
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
            innerContentStack.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: Constants.contentSpacing),
            innerContentStack.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalPadding),
            innerContentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalPadding),
            innerContentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding)
        ])
        
        updateUI()
    }
    
    // MARK: - Private methods
    private func updateUI() {
        switch state {
        case .loading:
            break
        case .content(let todoViewModel):
            titleLabel.text = todoViewModel.title
            todoLabel.text = todoViewModel.todo
            dateLabel.text = todoViewModel.date.shortFormat
            action = todoViewModel.action
            checkBox.isSelected = todoViewModel.completed
            updateCheckbox(with: todoViewModel.completed)
            checkBox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        }
    }
    
    private func updateCheckbox(with completed: Bool) {
        if completed {
            titleLabel.setStrikethrough(true)
            titleLabel.textColor = Color.white.color.withAlphaComponent(Constants.opacity)
            todoLabel.textColor = Color.white.color.withAlphaComponent(Constants.opacity)
        } else {
            titleLabel.setStrikethrough(false)
            titleLabel.textColor = Color.white.color
            todoLabel.textColor = Color.white.color
        }
    }
    
    @objc private func checkBoxTapped() {
        checkBox.isSelected.toggle()
        updateCheckbox(with: checkBox.isSelected)
        action?()
    }
    
    // MARK: - Public methods
    public func prepareForReuse() {
        titleLabel.attributedText = nil
        prepare(with: .empty)
    }
    
    public func prepare(with state: State, action: (()-> Void)? = nil) {
        self.state = state
        self.action = action
        updateUI()
    }
}

// MARK: - Constants
private extension TodoView {
    enum Constants {
        static let cornerRadius: CGFloat = 12
        static let spacing: CGFloat = 6
        static let opacity: CGFloat = 0.5
        static let checkboxHeight: CGFloat = 48
        static let checkboxWidth: CGFloat = 24
        static let verticalPadding: CGFloat = 12
        static let horizontalPadding: CGFloat = 20
        static let contentSpacing: CGFloat = 8
    }
}
