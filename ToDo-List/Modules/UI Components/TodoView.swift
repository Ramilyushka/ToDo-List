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
    }
}

final class TodoView: BaseView {
    // MARK: - Properties
    private var state: State
    private var action: (()-> Void)? = nil
    
    // MARK: - UI Properties
    private let checkBox = CheckboxButton()
    private let titleLabel = UILabel(font: .button)
    private let todoLabel = UILabel(font: .caption)
    private let dateLabel = UILabel(font: .caption, opacity: Constants.opacity)
    let innerContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.spacing
        stack.layer.cornerRadius = Constants.cornerRadius
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    init(state: State, action: (()-> Void)? = nil) {
        self.state = state
        self.action = action
        super.init()
    }
    
    override func setupSubViews() {
        backgroundColor = .clear
        layer.cornerRadius = Constants.cornerRadius
        
        titleLabel.attributedText = nil
        
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
    private func updateContent(model: TodoViewModel) {
        titleLabel.text = model.title
        todoLabel.text = model.todo
        dateLabel.text = model.date.shortFormat
    }
    
    private func updateUI() {
        switch state {
        case .loading:
            break
        case .content(let todoViewModel):
            updateContent(model: todoViewModel)
            action = todoViewModel.action
            checkBox.isSelected = todoViewModel.completed
            updateCheckbox(with: todoViewModel.completed)
        }
    }
    
    private func updateCheckbox(with completed: Bool) {
        checkBox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
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
        prepare(with: .content(.empty))
    }
    
    public func prepare(with state: State, action: (()-> Void)? = nil) {
        self.state = state
        self.action = action
        updateUI()
    }
    
    public static func prepareMenu(model: TodoViewModel) -> UIViewController {
        let view = TodoView(state: .content(model))
        let stack = view.innerContentStack
        let menuView = UIViewController()
        menuView.view.backgroundColor = Color.gray.color
        menuView.view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: menuView.view.topAnchor, constant: Constants.verticalPadding),
            stack.leadingAnchor.constraint(equalTo: menuView.view.leadingAnchor, constant: Constants.horizontalPadding),
            stack.trailingAnchor.constraint(equalTo: menuView.view.trailingAnchor, constant: -Constants.horizontalPadding),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: menuView.view.bottomAnchor, constant: -Constants.verticalPadding)
        ])
        menuView.preferredContentSize = Constants.menuSize
        return menuView
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
        static let menuSize: CGSize = CGSize(width: 320, height: 106)
    }
}
