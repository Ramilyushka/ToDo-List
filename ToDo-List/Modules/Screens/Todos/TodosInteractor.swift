//
//  TodosInteractor.swift
//  ToDo-List
//
//  Created by Ramilia on 06/11/25.
//
import Foundation

protocol TodosInteractorProtocol: AnyObject {
    func fetch()
    func delete(id: UUID)
}

protocol TodosOutputProtocol: AnyObject {
    func didFetch(todos: [TodoViewModel])
    func didComplete(id: UUID, value: Bool)
}

final class TodosInteractor: TodosInteractorProtocol {
    @UserDefaultsStorage(.isTodosLoadedFirstTime)
    private var isTodosLoadedFirstTime: Bool?
    
    // MARK: - Properties
    private let network: TodosNetworkProtocol
    private let coreData: TodosCoreDataProtocol
    weak var output: TodosOutputProtocol?
    
    // MARK: - Init
    init(network: TodosNetworkProtocol, coreData: TodosCoreDataProtocol) {
        self.network = network
        self.coreData = coreData
    }
    
    // MARK: - Private methods
    private func fetchFromApi() {
        network.getTodos { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.isTodosLoadedFirstTime = true
                    let todos = self.prepare(from: data.todos)
                    self.coreData.saveLoaded(todos)
                    self.output?.didFetch(todos: todos)
                case .failure(let error):
                    // TODO: - alert
                    print("FAILURE: \(error)")
                }
            }
        }
    }
    
    private func fetchFromCoreData() {
        let entitys = coreData.fetch()
        let todos = prepare(from: entitys)
        output?.didFetch(todos: todos)
    }
    
    private func prepare(from data: [TodoApi]) -> [TodoViewModel] {
        let todos: [TodoViewModel] = data.enumerated().compactMap { index, data in
            let completed = !data.completed
            let id = UUID()
            return TodoViewModel(data, id: id) { [weak self] in
                self?.complete(id: id, value: completed)
            }
        }
        return todos
    }
    
    private func prepare(from data: [TodoEntity]) -> [TodoViewModel] {
        let todos: [TodoViewModel] = data.enumerated().compactMap { index, entity in
            guard let id = entity.id else { return nil }
            let completed = !entity.completed
            return TodoViewModel(entity, id: id) { [weak self] in
                self?.complete(id: id, value: completed)
            }
        }
        return todos
    }
    
    private func complete(id: UUID, value: Bool) {
        coreData.complete(id, value: value)
        output?.didComplete(id: id, value: value)
    }
    
    // MARK: - TodosInteractorProtocol
    func fetch() {
        if let loaded = isTodosLoadedFirstTime, loaded {
            fetchFromCoreData()
        } else {
            fetchFromApi()
        }
    }
    
    func delete(id: UUID) {
        coreData.delete(id)
        fetchFromCoreData() //TODO: либо удалить из масива todos элемент и перерисовать таблицу ???
    }
}
