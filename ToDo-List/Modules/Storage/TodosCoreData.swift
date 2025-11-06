//
//  TodosCoreData.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//
import CoreData
import UIKit

protocol TodosCoreDataProtocol {
    //TODO: через throw
    func fetch() -> [TodoEntity]
    func saveLoaded(_ todos: [TodoViewModel])
    func save(_ todo: TodoViewModel)
    func complete(_ id: UUID, value: Bool)
    func delete(_ id: UUID)
}

final class TodosCoreData {
    // MARK: - Properties
    private let container: NSPersistentContainer
    private var context: NSManagedObjectContext {
        container.viewContext
    }
    
    // MARK: - Init
    init(modelName: String = "Todos") {
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка загрузки Core Data: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Private methods
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Ошибка при сохранении контекста: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetch(with id: UUID) throws -> TodoEntity? {
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
    
    private func new(_ todo: TodoViewModel) {
        let entity = TodoEntity(context: context)
        entity.id = todo.id
        entity.title = todo.title
        entity.todo = todo.todo
        entity.date = todo.date
        entity.completed = todo.completed

        saveContext()
        print("Todo сохранeн: \(todo.title)")
    }
}


// MARK: - TodosCoreDataProtocol
extension TodosCoreData: TodosCoreDataProtocol {
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
            new(todo)
        }
    }
    
    func save(_ todo: TodoViewModel) {
        do {
            guard let entity = try fetch(with: todo.id) else {
                new(todo)
                return
            }
            entity.title = todo.title
            entity.todo = todo.todo
            saveContext()
        } catch {
            print("Ошибка при получении todos: \(error)")
        }
    }
    
    func complete(_ id: UUID, value: Bool) {
        do {
            let entity = try fetch(with: id)
            entity?.completed = value
            saveContext()
            print("Todo completed сохранeн: \(id)")
        } catch {
            print("Ошибка при получении todos: \(error)")
        }
    }
    
    func delete(_ id: UUID) {
        do {
            guard let entity = try fetch(with: id) else {
                print("Ошибка при проверке существования todo")
                return
            }
            context.delete(entity)
            saveContext()
            print("Todo удалeно: \(id)")
        } catch {
            print("Ошибка при получении todos: \(error)")
        }
    }
}
