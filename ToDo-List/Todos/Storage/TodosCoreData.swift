//
//  TodosCoreData.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//
import CoreData
import UIKit

final class TodosCoreData {
    private let container: NSPersistentContainer
    
    init(modelName: String = "Todos") {
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка загрузки Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    private var context: NSManagedObjectContext {
        container.viewContext
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Ошибка при сохранении контекста: \(error.localizedDescription)")
            }
        }
    }
}


extension TodosCoreData {
    func saveLoaded(_ todos: [TodoUI]) {
        for todo in todos {
            save(todo)
        }
    }
    
    func save(_ todo: TodoUI) {
        let entity = TodoEntity(context: context)
        entity.title = todo.title
        entity.todo = todo.todo
        entity.date = todo.date
        entity.completed = todo.completed

        saveContext()
        print("Todo сохранeн: \(todo.title)")
    }

    func fetch() -> [TodoUI] {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        do {
            let objects = try context.fetch(request)
            let todos: [TodoUI] = objects.compactMap {
                .init($0)
            }
            return todos
        } catch {
            print("Ошибка при получении todos: \(error)")
            return []
        }
    }
}
