//
//  TodoDetailViewController.swift
//  ToDo-List
//
//  Created by Ramilia on 06/11/25.
//
import UIKit

protocol TodoDetailViewProtocol {
    func update()
}

final class TodoDetailViewController: UIViewController, TodoDetailViewProtocol {
    
    private var todoForm: TodoDetailView.Form
    
    private let detailView = TodoDetailView(form: .new)
    
    init(todoForm: TodoDetailView.Form) {
        self.todoForm = todoForm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        update()
    }
    
    private func setupSubViews() {
        view.backgroundColor = Color.black.color
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func update() {
        detailView.prepare(with: todoForm)
    }
}
