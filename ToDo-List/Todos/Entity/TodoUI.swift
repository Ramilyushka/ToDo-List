//
//  TaskModel.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//

import Foundation

struct TodoUI {
    let title: String
    let todo: String
    let date: Date
    let completed: Bool
    
    init(title: String, todo: String, date: Date, completed: Bool) {
        self.title = title
        self.todo = todo
        self.date = date
        self.completed = completed
    }
    
    init(_ data: TodoApi) {
        self.title = "Задача №" + data.id.description
        self.todo = data.todo
        self.date = Date()
        self.completed = data.completed
    }
    
    init(_ entity: TodoEntity) {
        self.title = entity.title ?? "????"
        self.todo = entity.todo ?? "????"
        self.date = entity.date ?? Date.distantPast
        self.completed = entity.completed
    }
}
