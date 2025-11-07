//
//  MockNetwork.swift
//  ToDo-List
//
//  Created by Ramilia on 08/11/25.
//
import Foundation
@testable import ToDo_List

// MARK: - Mock classes
final class MockNetwork: TodosNetworkProtocol {
    var getTodosCalled = false
    var shouldReturnError = false
    var mockTodos: [TodoApi] = []

    func getTodos(completion: @escaping (Result<TodosResponse, Error>) -> Void) {
        getTodosCalled = true
        if shouldReturnError {
            completion(.failure(NSError(domain: "NetworkError", code: -1)))
        } else {
            completion(.success(TodosResponse(todos: mockTodos)))
        }
    }
}
