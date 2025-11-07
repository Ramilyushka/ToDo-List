//
//  ViewController.swift
//  ToDo-List
//
//  Created by Ramilia on 02/11/25.
//
import UIKit

protocol TodosViewProtocol: AnyObject {
    func update()
}

final class TodosViewController: UIViewController {
    // MARK: - Properties
    private let presenter: TodosPresenterProtocol
    
    // MARK: - UI properties
    private let headerLabel = UILabel(font: .appFont(.header))
    private let searchField: UISearchTextField = {
        let searchField = UISearchTextField()
        searchField.tintColor = .appWhite50
        searchField.textColor = .appWhite
        searchField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: UIColor.appWhite50]
        )
        searchField.returnKeyType = .done
        searchField.translatesAutoresizingMaskIntoConstraints = false
        return searchField
    }()
    private let todosTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(TodoCell.self)
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = Constants.stackSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var footerView = TodoFooterView { [weak self] in
        self?.presenter.add()
    }
    
    // MARK: - Override
    init(presenter: TodosPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup view properties
    private func setupViews() {
        view.backgroundColor = .appBlack
        searchField.text = ""
        headerLabel.text = "Задачи"
        searchField.delegate = self
        todosTableView.dataSource = self
        todosTableView.delegate = self
        todosTableView.reloadData()
        
        [headerLabel, searchField, todosTableView].forEach(stackView.addArrangedSubview)
        view.addSubview(stackView)
        view.addSubview(footerView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchField.heightAnchor.constraint(equalToConstant: Constants.searchHeight),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalPadding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            stackView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ])
    }
}

// MARK: - TaskListViewProtocol
extension TodosViewController: TodosViewProtocol {
    func update() {
        footerView.setText(presenter.countText)
        todosTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension TodosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TodoCell = tableView.dequeueReusableCell()
        let todo = presenter.getTodoEntity(index: indexPath.row)
        cell.update(with: todo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         presenter.edit(index: indexPath.row)
     }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint)
    -> UIContextMenuConfiguration? {
        let uiMenu = createUIMenu(indexPath: indexPath)
        let model = presenter.getTodoEntity(index: indexPath.row)
        let view = TodoView.prepareMenu(model: model) //TODO: перенести в презентер ???
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: { return view },
            actionProvider: { _ in uiMenu }
        )
    }
    
    private func createUIMenu(indexPath: IndexPath) -> UIMenu {
        let edit = UIAction(.edit) { [weak self] _ in
            self?.presenter.edit(index: indexPath.row)
        }

        let share = UIAction(.share) { _ in }
        
        let delete = UIAction(.delete) { [weak self] _ in
            self?.presenter.delete(index: indexPath.row)
        }

        return UIMenu(title: "", children: [edit, share, delete])
    }
}

// MARK: - UITextFieldDelegate
extension TodosViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter.search(text: textField.text)
    }
    
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - Extension: Constants
private extension TodosViewController {
    enum Constants {
        static let stackSpacing: CGFloat = 16
        static let spacing: CGFloat = 6
        static let verticalPadding: CGFloat = 16
        static let horizontalPadding: CGFloat = 8
        static let searchHeight: CGFloat = 36
    }
}
