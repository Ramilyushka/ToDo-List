//
//  TodoDetailPresenterTests.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
import XCTest
@testable import ToDo_List

final class TodoDetailPresenterTests: XCTestCase {
    
    var presenter: TodoDetailPresenter?
    let interactor = MockTodoDetailInteractor()
    let router = MockTodoDetailRouter()
    let view = MockTodoDetailView()
    
    let expectation = XCTestExpectation(description: "Wait for fetch completion")
    
    override func setUp() {
        super.setUp()
        presenter = TodoDetailPresenter(interactor: interactor, router: router)
        presenter?.view = view
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        // when
        presenter?.viewDidLoad()
        // then
        XCTAssertTrue(interactor.updatedCalled)

    }
    
    func test_save_withNewForm() {
        // given
        let newTodo = Todos.model
        
        // when
        presenter?.save(title: newTodo.title, todo: newTodo.todo)
        
        // then
        XCTAssertTrue(interactor.savedCalled)
        XCTAssertEqual(interactor.title, newTodo.title)
    }
    
    func test_didUpdate_new() {
        // when
        presenter?.didUpdate(with: .new)
        
        // then
        XCTAssertTrue(view.newFormUpdatedCalled)
        XCTAssertFalse(view.editFormUpdatedCalled)
    }
    
    func test_didUpdate_edit() {
        // when
        presenter?.didUpdate(with: .edit(Todos.model))
        
        // then
        XCTAssertTrue(view.editFormUpdatedCalled)
        XCTAssertFalse(view.newFormUpdatedCalled)
    }
    
    func test_didSave_close() {
        // when
        presenter?.didSave()
        
        // then
        XCTAssertTrue(router.closedCalled)
    }
}
