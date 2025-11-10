//
//  MockCoreData.swift
//  ToDo-List
//
//  Created by R amilia on 08/11/25.
//
import Foundation
import CoreData
@testable import ToDo_List

final class MockTodosCoreData: TodosCoreDataProtocol {
    
    private let container: NSPersistentContainer = NSPersistentContainer(name: "Todos")
    private var context: NSManagedObjectContext {
        container.viewContext
    }
    
    var fetchCalled = false
    var searchCalled = false
    var saveCalled = false
    var deleteCalled = false
    var completeCalled = false
    
    var mockSavedTodo: TodoViewModel?
    var mockEntities: [ToDo_List.TodoEntity] = []
    var savedLoaded: [TodoViewModel] = []
    
    func fetch() -> [ToDo_List.TodoEntity] {
        fetchCalled = true
        
        let entity1 = prepareEntity()
        let entity2 = prepareEntity()
        mockEntities = [entity1, entity2]
        
        return mockEntities
    }
    
    func save(_ todo: ToDo_List.TodoViewModel) {
        saveCalled = true
        mockSavedTodo = todo
    }
    
    func saveLoaded(_ todos: [TodoViewModel]) {
        savedLoaded = todos
    }
    
    func delete(_ id: UUID) {
        deleteCalled = true
    }
    
    func complete(_ id: UUID, value: Bool) {
        completeCalled = true
    }
    
    func search(with text: String) -> [ToDo_List.TodoEntity]? {
        searchCalled = true
        
        let entity1 = prepareEntity(title: text)
        let entity2 = prepareEntity(title: text)
        mockEntities = [entity1, entity2]
        
        return mockEntities
    }
    
    private func prepareEntity(id: UUID? = nil, title: String? = nil, todo: String? = nil) -> ToDo_List.TodoEntity {
        let entity = ToDo_List.TodoEntity(context: context)
        entity.id = id ?? UUID()
        entity.title = (title ?? "Test") + Int.random(in: 1...10).description
        entity.todo = (todo ?? "Test") + Int.random(in: 1...10).description
        return entity
    }
}
