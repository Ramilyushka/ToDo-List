//
//  TodosPresenterTests.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
import XCTest
@testable import ToDo_List

final class TodosPresenterTests: XCTestCase {
    
    var presenter: TodosPresenter?
    let mockInteractor = MockTodosInteractor()
    let mockRouter = MockTodosRouter()
    let mockView = MockTodosView()
    
    override func setUp() {
        super.setUp()
        presenter = TodosPresenter(interactor: mockInteractor, router: mockRouter)
        presenter?.view = mockView
    }
    
    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        // when
        presenter?.viewDidLoad()
        
        // then
        XCTAssertTrue(mockInteractor.fetchCalled)
    }
    
    func test_viewUpdate() {
        // when
        presenter?.didFetch(todos: Todos.models)
        
        // then
        XCTAssertTrue(mockView.updateCalled)
    }
    
    func test_countText() {
        //given
        let countText = Todos.models.count.description + " задач"
        
        // when
        presenter?.didFetch(todos: Todos.models)
        
        // then
        XCTAssertEqual(presenter?.countText, countText)
    }
    
    func test_getNumberOfRows() {
        // given
        presenter?.didFetch(todos: Todos.models)
        
        // when
        let count = presenter?.getNumberOfRows() ?? -1
        
        // then
        XCTAssertTrue(count >= 0 && count == Todos.models.count)
    }
    
    func test_getTodoEntity() {
        // given
        presenter?.didFetch(todos: Todos.models)
        let mock = Todos.models[0]
        
        // when
        let model: TodoViewModel = presenter?.getTodoEntity(index: 0) ?? .empty
        
        // then
        XCTAssertEqual(model.title, mock.title)
    }
    
    func test_delete() {
        // given
        presenter?.didFetch(todos: Todos.models)
        let id = Todos.models[0].id
        
       // when
        presenter?.delete(index: 0)
        
        // then
        XCTAssertTrue(mockInteractor.deleteCalled)
        XCTAssertEqual(mockInteractor.id, id)
    }
    
    func test_add() {
        // when
        presenter?.add()
        
        // then
        XCTAssertTrue(mockRouter.newFormCalled)
        XCTAssertFalse(mockRouter.editFormCalled)
        XCTAssertNil(mockRouter.idForEditedTodo)
    }
    
    func test_edit() {
        // given
        presenter?.didFetch(todos: Todos.models)
        let id = Todos.models[0].id

        // when
        presenter?.edit(index: 0)
        
        // then
        XCTAssertTrue(mockRouter.editFormCalled)
        XCTAssertFalse(mockRouter.newFormCalled)
        XCTAssertEqual(mockRouter.idForEditedTodo, id)
    }
    
    func test_search() {
        // given
        let searchText = "text"
        
        // when
        presenter?.search(text: searchText)
        
        // then
        XCTAssertTrue(mockInteractor.searchCalled)
        XCTAssertEqual(mockInteractor.searchText, searchText)
    }
    
    func test_complete() {
        // given
        let id = UUID()
        let todo = TodoViewModel(id: id, title: "Test", todo: "Test", date: Date(), completed: false)
        presenter?.didFetch(todos: [todo])
        
        // when
        presenter?.didComplete(id: id, value: true)
        
        // then
        let updated = presenter?.getTodoEntity(index: 0) ?? .empty
        XCTAssertTrue(updated.completed)
    }
}
