//
//  MockTaskArray.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//

import Foundation

struct MockTaskList {
    static let tasks: [TaskEntity] = [
        .init(
            title: "Почитать книгу",
            description: "Составить список необходимых продуктов для ужина. Не забыть проверить, что уже есть в холодильнике.",
            date: Date()
        ),
        .init(title: "Уборка в квартире", description: "Провести генеральную уборку в квартире", date: Date()),
        .init(title: "Task 1", description: "Description 1", date: Date()),
        .init(title: "Task 2", description: "Description 2", date: Date())
    ]
}
