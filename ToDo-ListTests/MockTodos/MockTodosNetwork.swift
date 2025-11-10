//
//  MockNetwork.swift
//  ToDo-List
//
//  Created by Ramilia on 08/11/25.
//
import Foundation
@testable import ToDo_List

final class MockTodosNetwork: TodosNetworkProtocol {
    var getTodosCalled: Bool = false
    var todosResult: Result<TodosResponse, Error>?
    
    func getTodos(completion: @escaping (Result<TodosResponse, Error>) -> Void) {
        getTodosCalled = true
        DispatchQueue.global().async {
            if let result = self.todosResult {
                completion(result)
            } else {
                completion(.failure(NSError(domain: "NoResult", code: -1)))
            }
        }
    }
}
