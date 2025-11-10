//
//  MockTodosRouter.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
import Foundation
@testable import ToDo_List

final class MockTodosRouter: TodosRouterProtocol {
    
    var newFormCalled = false
    var editFormCalled = false
    
    var idForEditedTodo: UUID?
    
    func navigateToTodoDetail(with form: ToDo_List.TodoDetailView.Form) {
       switch form {
       case .new:
           newFormCalled = true
       case .edit(let todo):
           editFormCalled = true
           idForEditedTodo = todo.id
        }
    }
}
