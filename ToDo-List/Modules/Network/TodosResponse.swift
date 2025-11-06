//
//  TodosResponse.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//

struct TodosResponse: Codable {
    let todos: [TodoApi]
}

struct TodoApi: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}
