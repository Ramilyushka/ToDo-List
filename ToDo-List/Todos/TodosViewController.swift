//
//  ViewController.swift
//  ToDo-List
//
//  Created by Ramilia on 02/11/25.
//
import UIKit

protocol TodosViewProtocol: AnyObject {
    func update()
    func add()
}

final class TodosViewController: UIViewController {
    // MARK: - Properties
    private let presenter: TodosPresenterProtocol
    
    // MARK: - UI properties
    private let headerLabel = UILabel(font: .header)
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.barTintColor = .clear
        searchBar.searchTextField.backgroundColor = Color.gray.color
        return searchBar
    }()
    private let todosTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(TodoCell.self)
        tableView.isScrollEnabled = true
        tableView.allowsSelection = false
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
    
    private lazy var footerView = FooterView { [weak self] in
        self?.add()
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
        view.backgroundColor = Color.black.color
        headerLabel.text = "Задачи"
        todosTableView.dataSource = self
        todosTableView.delegate = self
        todosTableView.reloadData()
        
        [headerLabel, searchBar, todosTableView].forEach(stackView.addArrangedSubview)
        view.addSubview(stackView)
        view.addSubview(footerView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
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
    
    func add() {
        todosTableView.reloadData()
        let random = [1,2,3,4,5,9,10].randomElement()?.description ?? "---"
        footerView.setText(random + " задач")
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
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint)
    -> UIContextMenuConfiguration? {
        let uiMenu = createUIMenu(indexPath: indexPath)
        let model = presenter.getTodoEntity(index: indexPath.row)
        let view = TodoView.prepareMenu(model: model)
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: { return view },
            actionProvider: { _ in uiMenu }
        )
    }
    
    private func createUIMenu(indexPath: IndexPath) -> UIMenu {
        let edit = UIAction(.edit) { [weak self] _ in
            self?.add() //TODO: 
        }

        let share = UIAction(.share) { _ in }
        
        let delete = UIAction(.delete) { [weak self] _ in
            self?.presenter.delete(index: indexPath.row)
        }

        return UIMenu(title: "", children: [edit, share, delete])
    }
}

// MARK: - Extension: Constants
private extension TodosViewController {
    enum Constants {
        static let stackSpacing: CGFloat = 16
        static let spacing: CGFloat = 6
        static let verticalPadding: CGFloat = 16
        static let horizontalPadding: CGFloat = 8
    }
}
