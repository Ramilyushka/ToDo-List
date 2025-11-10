//
//  MockTaskArray.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//
import Foundation
@testable import ToDo_List

typealias Todos = MockTodoViewModel

struct MockTodoViewModel {
    static let models: [TodoViewModel] = [
        .init(
            id: UUID(),
            title: "Почитать книгу",
            todo: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
            date: Date(),
            completed: true
        ),
        .init(
            id: UUID(),
            title: "Уборка в квартире",
            todo: "Провести генеральную уборку в квартире",
            date: Date(),
            completed: false
        ),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(id: UUID(), title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(id: UUID(), title: "Task 2", todo: "Description 2", date: Date(), completed: true)
    ]
    
    static let model: TodoViewModel = .init(id: UUID(), title: "Title", todo: "Todo", date: Date(), completed: false)
}
