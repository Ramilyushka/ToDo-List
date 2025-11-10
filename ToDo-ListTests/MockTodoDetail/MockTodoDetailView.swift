//
//  MockTodoDetailView.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
@testable import ToDo_List

final class MockTodoDetailView: TodoDetailViewProtocol {
    
    var newFormUpdatedCalled = false
    var editFormUpdatedCalled = false
    
    func update(with form: ToDo_List.TodoDetailView.Form) {
        switch form {
        case .new:
            newFormUpdatedCalled = true
        case .edit(_):
            editFormUpdatedCalled = true
        }
    }
}
