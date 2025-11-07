//
//  MockCoreData.swift
//  ToDo-List
//
//  Created by R amilia on 08/11/25.
//
import Foundation
@testable import ToDo_List

final class MockCoreData: TodosCoreDataProtocol {
    var fetchCalled = false
    var searchCalled = false
    var saveCalled = false
    var deleteCalled = false
    var completeCalled = false

    var mockEntities: [TodoEntity] = []
    var mockSearchResult: [TodoEntity]? = nil

    func fetch() -> [TodoEntity] {
        fetchCalled = true
        return mockEntities
    }

    func save(_ todo: ToDo_List.TodoViewModel) {
       // <#code#>
    }
    
    func saveLoaded(_ todos: [TodoViewModel]) {
        saveCalled = true
    }

    func delete(_ id: UUID) {
        deleteCalled = true
    }

    func complete(_ id: UUID, value: Bool) {
        completeCalled = true
    }

    func search(with text: String) -> [TodoEntity]? {
        searchCalled = true
        return mockSearchResult
    }
}
