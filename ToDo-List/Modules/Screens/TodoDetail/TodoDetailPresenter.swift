//
//  TodoDetailPresenter.swift
//  ToDo-List
//
//  Created by Ramilia on 07/11/25.
//
import Foundation

protocol TodoDetailPresenterProtocol {
    func viewDidLoad()
    func save(title: String?, detail: String?)
}

final class TodoDetailPresenter: TodoDetailPresenterProtocol, TodoDetailOutputProtocol {
    // MARK: - Properties
    private let interactor: TodoDetailInteractorProtocol
    private let router: TodoDetailRouterProtocol
    private let form: TodoDetailView.Form
    weak var view: TodoDetailViewProtocol?
    
    // MARK: - Init
    init(form: TodoDetailView.Form, interactor: TodoDetailInteractorProtocol, router: TodoDetailRouterProtocol) {
        self.form = form
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - TodoDetailPresenterProtocol
    func viewDidLoad() {
        view?.update(with: form)
    }
    
    func save(title: String?, detail: String?) {
        if let title, let detail {
            var new: TodoViewModel
            switch form {
            case .new:
                new = TodoViewModel(id: UUID(), title: title, todo: detail, date: Date(), completed: false)
            case .edit(let old):
                new = TodoViewModel(id: old.id, title: title, todo: detail, date: old.date, completed: old.completed)
            }
            interactor.save(new)
        } else {
            // TODO: PopUpMessage or подсказки
        }
    }
    
    //MARK: - TodoDetailOutputProtocol
    func didSave() {
        router.close()
    }
}
