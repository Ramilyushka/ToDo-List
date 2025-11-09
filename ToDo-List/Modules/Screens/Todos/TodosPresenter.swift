//
//  TodosPresenter.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//
import Foundation

protocol TodosPresenterProtocol: AnyObject {
    var countText: String { get }
    func viewDidLoad()
    func getNumberOfRows() -> Int
    func getTodoEntity(index: Int) -> TodoViewModel
    func delete(index: Int)
    func add()
    func edit(index: Int)
    func search(text: String?)
}

final class TodosPresenter: TodosPresenterProtocol {
    // MARK: - Properties
    private var todos: [TodoViewModel] = []
    
    private let interactor: TodosInteractorProtocol
    private let router: TodosRouterProtocol
    weak var view: TodosViewProtocol?
    
    // MARK: - Init
    init(interactor: TodosInteractorProtocol, router: TodosRouterProtocol) {
        self.interactor = interactor
        self.router = router
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(update),
            name: .todoSaved,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func update() {
        interactor.fetch()
    }
    
    // MARK: - TodosPresenterProtocol
    var countText: String {
        todos.count.description + " задач"
    }
    
    func viewDidLoad() {
        interactor.fetch()
    }
    
    func getNumberOfRows() -> Int {
        return todos.count
    }
    
    func getTodoEntity(index: Int) -> TodoViewModel {
        return todos[index]
    }
    
    func delete(index: Int) {
        let todo = todos[index]
        interactor.delete(id: todo.id)
    }
    
    func add() {
        router.navigateToTodoDetail(with: .new)
    }
    
    func edit(index: Int) {
        let todo = todos[index]
        router.navigateToTodoDetail(with: .edit(todo))
    }
    
    func search(text: String?) {
        interactor.search(text: text)
    }
}

extension TodosPresenter: TodosOutputProtocol {
    func didFetch(todos: [TodoViewModel]) {
        self.todos = todos
        view?.update()
    }
    
    func didComplete(id: UUID, value: Bool) {
        guard let index = todos.firstIndex(where: { $0.id == id }) else { return }
        todos[index].completed = value
    }
}
