//
//  TodoDetailViewController.swift
//  ToDo-List
//
//  Created by Ramilia on 06/11/25.
//
import UIKit

protocol TodoDetailViewProtocol: AnyObject {
    func update(with form: TodoDetailView.Form)
}

final class TodoDetailViewController: UIViewController, TodoDetailViewProtocol {
    private let presenter: TodoDetailPresenterProtocol
    private lazy var detailView = TodoDetailView(form: .new) { [weak self] in
        self?.buttonTapped()
    }
    
    // MARK: - Override
    init(presenter: TodoDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        presenter.viewDidLoad()
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
    
    private func buttonTapped() {
        presenter.save(title: detailView.title, detail: detailView.detail)
    }
    
    // MARK: - TodoDetailViewProtocol
    func update(with form: TodoDetailView.Form) {
        detailView.prepare(with: form)
    }
}
