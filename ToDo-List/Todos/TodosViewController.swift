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
    func edit(_ task: TodoViewModel)
    func delete(_ task: TodoViewModel)
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
    private let tasksTableView: UITableView = {
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
        tasksTableView.dataSource = self
        tasksTableView.reloadData()
        
        [headerLabel, searchBar, tasksTableView].forEach(stackView.addArrangedSubview)
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
        tasksTableView.reloadData()
    }
    
    func add() {
        tasksTableView.reloadData()
        let random = [1,2,3,4,5,9,10].randomElement()?.description ?? "---"
        footerView.setText(random + " задач")
    }
    
    func edit(_ task: TodoViewModel) {
        tasksTableView.reloadData()
    }
    
    func delete(_ task: TodoViewModel) {
        tasksTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension TodosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TodoCell = tableView.dequeueReusableCell()
        let todo = presenter.getTodoEntity(index: indexPath.row)
        cell.update(with: todo)
        return cell
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
