//
//  MockInteractor.swift
//  ToDo-List
//
//  Created by Ramilia on 08/11/25.
//
import Foundation
@testable import ToDo_List

final class MockTodosOutput: TodosOutputProtocol {
    var didFetchCalled = false
    var didCompleteCalled = false
  
    var fetchedTodos: [TodoViewModel] = []
    var completedId: UUID? = nil
    var completedValue: Bool? = nil

    var onDidFetch: (() -> Void)?
    
    func didFetch(todos: [TodoViewModel]) {
        didFetchCalled = true
        fetchedTodos = todos
        onDidFetch?()
    }

    func didComplete(id: UUID, value: Bool) {
        didCompleteCalled = true
        completedId = id
        completedValue = value
    }
}
