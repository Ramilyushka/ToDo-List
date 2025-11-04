//
//  MockTaskArray.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//

import Foundation

struct MockTaskList {
    static let tasks: [TodoUI] = [
        .init(
            title: "Почитать книгу",
            todo: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
            date: Date(),
            completed: true
        ),
        .init(title: "Уборка в квартире", todo: "Провести генеральную уборку в квартире", date: Date(), completed: false),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: true),
        .init(title: "Task 1", todo: "Description 1", date: Date(), completed: false),
        .init(title: "Task 2", todo: "Description 2", date: Date(), completed: true)
    ]
}
