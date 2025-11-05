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
    private func fetch(with id: UUID?) throws -> TodoEntity? {
        guard let id = id else {
            return nil
        }
        
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            print("Ошибка при проверке существования todo: \(error)")
            return nil
        }
    }
    
    func fetch() -> [TodoEntity] {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Ошибка при получении todos: \(error)")
            return []
        }
    }
    
    func saveLoaded(_ todos: [TodoViewModel]) {
        for todo in todos {
            save(todo)
        }
    }
    
    func save(_ todo: TodoViewModel) {
        let entity = TodoEntity(context: context)
        entity.id = todo.id
        entity.title = todo.title
        entity.todo = todo.todo
        entity.date = todo.date
        entity.completed = todo.completed

        saveContext()
        print("Todo сохранeн: \(todo.title)")
    }
    
    func complete(_ id: UUID?, value: Bool) {
        do {
            let entity = try fetch(with: id)
            entity?.completed = value
            saveContext()
            print("Todo completed сохранeн: \(id)")
        } catch {
            print("Ошибка при получении todos: \(error)")
        }
    }
}
