//
//  TaskListNetwork.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//

import Foundation

typealias Completion = (Result<TodosResponse, Error>) -> Void

protocol TodosNetworkProtocol {
    func getTodos(completion: @escaping Completion)
}

final class TodosNetwork: TodosNetworkProtocol {

    private let networkClient: NetworkClient = DefaultNetworkClient()

    func getTodos(completion: @escaping Completion) {

        let request = requestGetTodos()
        
        networkClient.send(request: request, type: TodosResponse.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
