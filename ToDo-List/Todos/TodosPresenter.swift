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
}

final class TodosPresenter: TodosPresenterProtocol {
    @UserDefaultsStorage(.isTodosLoadedFirstTime)
    private var isTodosLoadedFirstTime: Bool?
    
    // MARK: - Properties
    private var todos: [TodoViewModel] = []
    private let network: TodosNetworkProtocol
    private let coreData = TodosCoreData()
    weak var view: TodosViewProtocol?
    
    // MARK: - Init
    init(network: TodosNetworkProtocol) {
        self.network = network
    }
    
    // MARK: - Private methods
    private func fetchFromApi() {
        network.getTodos { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.isTodosLoadedFirstTime = true
                    self.convertToViewModel(data.todos)
                    self.view?.update()
                    self.coreData.saveLoaded(self.todos)
                case .failure(let error):
                    // TODO: - alert
                    print("FAILURE: \(error)")
                }
            }
        }
    }
    
    private func fetchFromCoreData() {
        let entitys = coreData.fetch()
        convertToViewModel(entitys)
        view?.update()
    }
    
    private func complete(for id: UUID, value: Bool) {
        coreData.complete(id, value: value)
        var todo = todos.first(where: { $0.id == id })
        todo?.completed = value
    }
    
    private func convertToViewModel(_ data: [TodoApi]) {
        todos = data.enumerated().compactMap { index, data in
            let completed = !data.completed
            let id = UUID()
            return TodoViewModel(data, id: id) { [weak self] in
                self?.complete(for: id, value: completed)
            }
        }
    }
    
    private func convertToViewModel(_ data: [TodoEntity]) {
        todos = data.enumerated().compactMap { index, entity in
            guard let id = entity.id else { return nil }
            let completed = !entity.completed
            return TodoViewModel(entity, id: id) { [weak self] in
                self?.complete(for: id, value: completed)
            }
        }
    }
    
    // MARK: - TodosPresenterProtocol
    var countText: String {
        todos.count.description + " задач"
    }
    
    func viewDidLoad() {
        if let loaded = isTodosLoadedFirstTime, loaded {
            fetchFromCoreData()
            print("fetchFromCoreData")
        } else {
            fetchFromApi()
            print("fetchFromApi")
        }
    }
    func getNumberOfRows() -> Int {
        return todos.count
    }
    
    func getTodoEntity(index: Int) -> TodoViewModel {
        return todos[index]
    }
    
    func delete(index: Int) {
        let todo = todos[index]
        coreData.delete(todo.id)
        fetchFromCoreData()
    }
}
