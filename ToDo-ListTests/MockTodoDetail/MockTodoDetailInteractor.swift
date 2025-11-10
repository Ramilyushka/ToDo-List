//
//  MockTodoDetailInteractor.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
@testable import ToDo_List

final class MockTodoDetailInteractor: TodoDetailInteractorProtocol {
    
    var updatedCalled = false
    var savedCalled = false
    var title: String?
    
    func update() {
        updatedCalled = true
    }
    
    func save(title: String?, todo: String?) {
        savedCalled = true
        self.title = title
    }
}
