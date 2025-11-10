//
//  MockTodosInteractor.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
import Foundation
@testable import ToDo_List

final class MockTodosInteractor: TodosInteractorProtocol {
    var fetchCalled = false
    var deleteCalled = false
    var searchCalled = false
    
    var id: UUID?
    var searchText: String?
    
    func fetch() {
        fetchCalled = true
    }
    
    func delete(id: UUID) {
        deleteCalled = true
        self.id = id
    }
    
    func search(text: String?) {
        searchCalled = true
        searchText = text
    }
}
