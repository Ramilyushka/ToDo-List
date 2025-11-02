//
//  ViewController.swift
//  ToDo-List
//
//  Created by Ramilia on 02/11/25.
//

import UIKit

class MainViewController: UIViewController {

    private let tasks: [TaskModel] = MockTaskArray.tasks
    
    private var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskCell.self)
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupViews()
    }
    
    private func setupViews() {
        title = "История"
        view.backgroundColor = .systemBackground
        view.addSubview(tasksTableView)
        tasksTableView.dataSource = self
        tasksTableView.reloadData()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.verticalPadding),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.verticalPadding)
        ])
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
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
private extension MainViewController {
    enum Constants {
        static let spacing: CGFloat = 6
        static let verticalPadding: CGFloat = 16
        static let horizontalPadding: CGFloat = 8
    }
}
