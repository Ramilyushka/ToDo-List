//
//  ViewController.swift
//  ToDo-List
//
//  Created by Ramilia on 02/11/25.
//
import UIKit

protocol TaskListViewProtocol: AnyObject {
    func showTaskList()
    func addTask()
    func editTask(_ task: TaskEntity)
    func deleteTask(_ task: TaskEntity)
}

final class TaskListViewController: UIViewController {
    // MARK: - Properties
    private let tasks: [TaskEntity] = MockTaskList.tasks
    
    // MARK: - UI properties
    private let headerLabel = UILabel(font: .header)
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.barTintColor = .clear
        searchBar.searchTextField.backgroundColor = Color.gray.color
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    private var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(TaskCell.self)
        tableView.isScrollEnabled = true
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var footerView = FooterView(text: "начало") { [weak self] in
        self?.addTask()
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
//            footerView.heightAnchor.constraint(equalToConstant: 68),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalPadding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.verticalPadding)
        ])
    }
}

// MARK: - TaskListViewProtocol
extension TaskListViewController: TaskListViewProtocol {
    func showTaskList() {
        tasksTableView.reloadData()
    }
    
    func addTask() {
        tasksTableView.reloadData()
        let random = [1,2,3,4,5,9,10].randomElement()?.description ?? "---"
        footerView.setText(random + " задач")
    }
    
    func editTask(_ task: TaskEntity) {
        tasksTableView.reloadData()
    }
    
    func deleteTask(_ task: TaskEntity) {
        tasksTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueReusableCell()
        let task = tasks[indexPath.row]
        cell.update(with: task)
        return cell
    }
}

// MARK: - Extension: Constants
private extension TaskListViewController {
    enum Constants {
        static let spacing: CGFloat = 6
        static let verticalPadding: CGFloat = 16
        static let horizontalPadding: CGFloat = 8
    }
}
