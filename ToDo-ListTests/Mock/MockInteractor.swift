//
//  MockInteractor.swift
//  ToDo-List
//
//  Created by Ramilia on 08/11/25.
//
import Foundation
@testable import ToDo_List

final class MockOutput: TodosOutputProtocol {
    var didFetchCalled = false
    var didCompleteCalled = false
    var fetchedTodos: [TodoViewModel] = []
    var completedId: UUID? = nil
    var completedValue: Bool? = nil

    func didFetch(todos: [TodoViewModel]) {
        didFetchCalled = true
        fetchedTodos = todos
    }

    func didComplete(id: UUID, value: Bool) {
        didCompleteCalled = true
        completedId = id
        completedValue = value
    }
}


final class MockInteractor: TodosInteractorProtocol {
    var isTodosLoadedFirstTime: Bool = false
    var output: TodosOutputProtocol!
    
    private var searchText: String?
    
    private func performFetch(with text: String?) {
        let text = text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let text, !text.isEmpty {
            if let coreFiltered = coreData.search(with: text) {
                let filtered = prepare(from: coreFiltered)
                output?.didFetch(todos: filtered)
            } //TODO: в случае ошибки
        } else {
            fetchAll()
        }
    }
    
    func fetch() {
        //<#code#>
    }
    
    func delete(id: UUID) {
      //  coreData.delete(id)
        performFetch(with: searchText)
    }
    
    func search(text: String?) {
        searchText = text
        performFetch(with: searchText)
    }
}
