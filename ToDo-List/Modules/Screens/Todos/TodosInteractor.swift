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
    func search(text: String?)
}

protocol TodosOutputProtocol: AnyObject {
    func didFetch(todos: [TodoViewModel])
    func didComplete(id: UUID, value: Bool)
}

final class TodosInteractor: TodosInteractorProtocol {
    @UserDefaultsStorage(.isTodosLoadedFirstTime)
    var isTodosLoadedFirstTime: Bool?
    
    // MARK: - Properties
    private let network: TodosNetworkProtocol
    private let coreData: TodosCoreDataProtocol
    weak var output: TodosOutputProtocol?
    
    private var searchText: String?
    
    // MARK: - Init
    init(network: TodosNetworkProtocol, coreData: TodosCoreDataProtocol) {
        self.network = network
        self.coreData = coreData
    }
    
    // MARK: - Private methods
    private func performFetch(with text: String?) {
        let text = text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            if let text, !text.isEmpty {
                if let coreFiltered = coreData.search(with: text) {
                    let filtered = prepare(from: coreFiltered)
                    DispatchQueue.main.async {
                        self.output?.didFetch(todos: filtered)
                    }
                } //TODO: в случае ошибки
            } else {
                fetchAll()
            }
        }
    }
    
    private func fetchAll() {
        if let loaded = isTodosLoadedFirstTime, loaded {
            fetchFromCoreData()
        } else {
            fetchFromApi()
        }
    }
    
    private func fetchFromApi() {
        network.getTodos { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.global(qos: .userInitiated).async {
                    self.isTodosLoadedFirstTime = true
                    let todos = self.prepare(from: data.todos)
                    self.coreData.saveLoaded(todos)
                    DispatchQueue.main.async {
                        self.output?.didFetch(todos: todos)
                    }
                }
            case .failure(let error):
                // TODO: - alert
                print("FAILURE: \(error)")
            }
        }
    }
    
    private func fetchFromCoreData() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let entitys = coreData.fetch()
            let todos = prepare(from: entitys)
            DispatchQueue.main.async {
                self.output?.didFetch(todos: todos)
            }
        }
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
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            coreData.complete(id, value: value)
            DispatchQueue.main.async {
                self.output?.didComplete(id: id, value: value)
            }
        }
    }
    
    // MARK: - TodosInteractorProtocol
    func fetch() {
        performFetch(with: searchText)
    }
    
    func delete(id: UUID) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            coreData.delete(id)
            performFetch(with: searchText)
        }
    }
    
    func search(text: String?) {
        searchText = text
        performFetch(with: searchText)
    }
}
