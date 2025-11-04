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
    func getTodoEntity(index: Int) -> TodoEntity
}

final class TodosPresenter: TodosPresenterProtocol {
    // MARK: - Properties
    private var todos: [TodoApi] = []
    private let network: TodosNetworkProtocol
    weak var view: TodosViewProtocol?
    
    // MARK: - Init
    init(network: TodosNetworkProtocol) {
        self.network = network
    }
    
    // MARK: - Private methods
    private func fetchTodos() {
        network.getTodos { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let todos):
                    self?.todos = todos.todos
                    self?.view?.update()
                case .failure(let error):
                    // TODO: - alert
                    print("FAILURE: \(error)")
                }
            }
        }
    }
    
    // MARK: - TodosPresenterProtocol
    var countText: String {
        todos.count.description + " задач"
    }
    
    func viewDidLoad() {
        fetchTodos()
    }
    func getNumberOfRows() -> Int {
        return todos.count
    }
    
    func getTodoEntity(index: Int) -> TodoEntity {
        let todoApi = todos[index]
        let entity = TodoEntity(
            title: "Задача №" + todoApi.id.description,
            description: todoApi.todo,
            date: Date(),
            completed: todoApi.completed
        )
        return entity
    }
}
