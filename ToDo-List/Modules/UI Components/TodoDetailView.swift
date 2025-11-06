//
//  TodoDetailView.swift
//  ToDo-List
//
//  Created by Ramilia on 06/11/25.
//

import UIKit

extension TodoDetailView {
    public enum Form {
        case new
        case edit(TodoViewModel)
    }
}

final class TodoDetailView: BaseView {
    // MARK: - Properties
    private var form: Form
    
    // MARK: - UI Properties
    private let titleField: UITextField = {
        let field = UITextField()
        field.font = Font.header.font
        field.layer.cornerRadius = Constants.radius
        field.layer.borderWidth = 1
        field.layer.borderColor = Color.gray.color.cgColor
        field.textColor = Color.white.color
        return field
    }()
    private let todoField: UITextView = {
        let field = UITextView()
        field.font = Font.button.font
        field.layer.cornerRadius = Constants.radius
        field.layer.borderWidth = 1
        field.layer.borderColor = Color.gray.color.cgColor
        field.textColor = Color.white.color
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let dateLabel = UILabel(font: .caption, opacity: Constants.opacity)
    let innerContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Font.button.font
        button.setTitleColor(Color.white.color, for: .normal)
        button.backgroundColor = Color.black.color
        button.layer.cornerRadius = Constants.radius
        button.isHidden = true
        return button
    }()
    
    // MARK: - Init
    init(form: Form) {
        self.form = form
        super.init()
    }
    
    override func setupSubViews() {
        backgroundColor = .clear
        
        addSubview(innerContentStack)
        innerContentStack.addArrangedSubview(titleField)
        innerContentStack.addArrangedSubview(dateLabel)
        innerContentStack.addArrangedSubview(todoField)
        innerContentStack.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
            todoField.heightAnchor.constraint(equalToConstant: Constants.todoHeight),
            innerContentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
            innerContentStack.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalPadding),
            innerContentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalPadding),
            innerContentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding)
        ])
        updateUI()
    }
    
    // MARK: - Private methods
    private func updateUI() {
        switch form {
        case .new:
            titleField.placeholder = "Название"
            todoField.text = "Описание"
            dateLabel.text = Date().shortFormat
            button.setTitle("Добавить", for: .normal)
        case .edit(let model):
            titleField.text = model.title
            todoField.text = model.todo
            dateLabel.text = model.date.shortFormat
            button.setTitle("Сохранить", for: .normal)
        }
    }
    
    // MARK: - Public methods
    public func prepare(with form: Form) {
        self.form = form
        updateUI()
    }
}

// MARK: - Constants
private extension TodoDetailView {
    enum Constants {
        static let radius: CGFloat = 8
        static let spacing: CGFloat = 8
        static let opacity: CGFloat = 0.5
        static let verticalPadding: CGFloat = 12
        static let horizontalPadding: CGFloat = 20
        static let todoHeight: CGFloat = 200
    }
}
