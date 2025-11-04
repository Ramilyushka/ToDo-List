//
//  MockTaskArray.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//

import Foundation

struct MockTaskList {
    static let tasks: [TodoEntity] = [
        .init(
            title: "Почитать книгу",
            description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
            date: Date(),
            completed: true
        ),
        .init(title: "Уборка в квартире", description: "Провести генеральную уборку в квартире", date: Date(), completed: false),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: false),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: false),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: false),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: false),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", description: "Description 1", date: Date(), completed: false),
        .init(title: "Task 2", description: "Description 2", date: Date(), completed: true)
    ]
}
