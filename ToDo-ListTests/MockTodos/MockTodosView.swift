//
//  MockTodosView.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
@testable import ToDo_List

final class MockTodosView: TodosViewProtocol {
    
    var updateCalled = false
    
    func update() {
        updateCalled = true
    }
}
