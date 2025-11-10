//
//  TodoDetailInteractorTests.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
import XCTest
@testable import ToDo_List

final class TodoDetailInteractorTests: XCTestCase {
    
    var interactor: TodoDetailInteractor?
    let mockCoreData = MockTodosCoreData()
    let mockOutput = MockTodoDetailOutput()
    let expectation = XCTestExpectation(description: "Wait for fetch completion")
    
    override func setUp() {
        super.setUp()
        interactor = TodoDetailInteractor(form: .new, coreData: mockCoreData)
        interactor?.output = mockOutput
        mockOutput.onDidFetch = {
            self.expectation.fulfill()
        }
    }
    
    override func tearDown() {
        interactor = nil
        super.tearDown()
    }
    
    func test_update() {
        // when
        interactor?.update()
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertTrue(mockOutput.didUpdateCalled)
        switch mockOutput.form {
        case .new:
            XCTAssertTrue(true)
        case .edit:
            break
        case .none:
            break
        }
    }
    
    func test_save() {
        // given
        let todo = Todos.model
        
        // when
        interactor?.save(title: todo.title, todo: todo.todo)
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertTrue(mockCoreData.saveCalled)
        XCTAssertEqual(mockCoreData.mockSavedTodo?.title, todo.title)
        XCTAssertTrue(mockOutput.didSaveCalled)
    }
}
