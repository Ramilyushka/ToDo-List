//
//  MockTodoDetailRouter.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
@testable import ToDo_List

final class MockTodoDetailRouter: TodoDetailRouterProtocol {
    
    var closedCalled = false
    
    func close() {
        closedCalled = true
    }
}
