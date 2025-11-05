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
    
    private func complete(at index: Int, value: Bool) {
        todos[index].completed = value
        coreData.complete(todos[index].id, value: value)
    }
    
    private func convertToViewModel(_ data: [TodoApi]) {
        todos = data.enumerated().compactMap { index, data in
            let completed = !data.completed
            return TodoViewModel(data) { [weak self] in
                self?.complete(at: index, value: completed)
            }
        }
    }
    
    private func convertToViewModel(_ data: [TodoEntity]) {
        todos = data.enumerated().compactMap { index, entity in
            let completed = !entity.completed
            return TodoViewModel(entity) { [weak self] in
                self?.complete(at: index, value: completed)
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
}
