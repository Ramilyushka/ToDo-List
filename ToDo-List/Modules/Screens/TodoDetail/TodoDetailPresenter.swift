//
//  TodoDetailPresenter.swift
//  ToDo-List
//
//  Created by Ramilia on 07/11/25.
//
import Foundation

protocol TodoDetailPresenterProtocol {
    func viewDidLoad()
    func save(title: String?, todo: String?)
}

final class TodoDetailPresenter: TodoDetailPresenterProtocol, TodoDetailOutputProtocol {
    // MARK: - Properties
    private let interactor: TodoDetailInteractorProtocol
    private let router: TodoDetailRouterProtocol
    weak var view: TodoDetailViewProtocol?
    
    // MARK: - Init
    init(interactor: TodoDetailInteractorProtocol, router: TodoDetailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - TodoDetailPresenterProtocol
    func viewDidLoad() {
        interactor.update()
    }
    
    func save(title: String?, todo: String?) {
        interactor.save(title: title, todo: todo)
    }
    
    //MARK: - TodoDetailOutputProtocol
    func didUpdate(with form: TodoDetailView.Form) {
        view?.update(with: form)
    }
    
    func didSave() {
        router.close()
    }
}
