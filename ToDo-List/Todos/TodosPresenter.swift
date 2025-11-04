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
    func getTodoEntity(index: Int) -> TodoUI
}

final class TodosPresenter: TodosPresenterProtocol {
    @UserDefaultsStorage(.isTodosLoadedFirstTime)
    private var isTodosLoadedFirstTime: Bool?
    
    // MARK: - Properties
    private var todos: [TodoUI] = []
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
                    self.todos = data.todos.compactMap {
                        TodoUI($0)
                    }
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
        todos = coreData.fetch()
        view?.update()
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
    
    func getTodoEntity(index: Int) -> TodoUI {
        return todos[index]
    }
}
