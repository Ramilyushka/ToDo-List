//
//  TaskModel.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//

import Foundation

struct TodoViewModel {
    let id: UUID?
    let title: String
    let todo: String
    let date: Date
    var completed: Bool
    var action: (() -> Void)? = nil
    
    init(id: UUID, title: String, todo: String, date: Date, completed: Bool, action: (() -> Void)? = nil) {
        self.id = id
        self.title = title
        self.todo = todo
        self.date = date
        self.completed = completed
        self.action = action
    }
    
    init(_ data: TodoApi, action: (() -> Void)? = nil) {
        self.id = UUID()
        self.title = "Задача №" + data.id.description
        self.todo = data.todo
        self.date = Date()
        self.completed = data.completed
        self.action = action
    }
    
    init(_ entity: TodoEntity, action: (() -> Void)? = nil) {
        self.id = entity.id
        self.title = entity.title ?? "????"
        self.todo = entity.todo ?? "????"
        self.date = entity.date ?? Date.distantPast
        self.completed = entity.completed
        self.action = action
    }
    
    mutating func toggleCompleted() {
        completed.toggle()
    }
}
