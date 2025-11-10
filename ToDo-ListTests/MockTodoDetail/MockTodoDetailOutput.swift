//
//  MockTodoDetailOutput.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
@testable import ToDo_List

final class MockTodoDetailOutput: TodoDetailOutputProtocol {
    
    var didSaveCalled = false
    var didUpdateCalled = false
    var form: ToDo_List.TodoDetailView.Form?
    
    var onDidFetch: (() -> Void)?
    
    func didSave() {
        didSaveCalled = true
        onDidFetch?()
    }
    
    func didUpdate(with form: ToDo_List.TodoDetailView.Form) {
        didUpdateCalled = true
        self.form = form
        onDidFetch?()
    }
}
