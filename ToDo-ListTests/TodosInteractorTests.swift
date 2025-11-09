//
//  InteractorTest.swift
//  ToDo-List
//
//  Created by Ramilia on 08/11/25.
//
import XCTest
import CoreData
@testable import ToDo_List

final class TodosInteractorTests: XCTestCase {
    
    var interactor: TodosInteractor?
    let mockNetwork: MockTodosNetwork = MockTodosNetwork()
    let mockCoreData: MockTodosCoreData = MockTodosCoreData()
    let mockOutput: MockTodosOutput = MockTodosOutput()
    let expectation = XCTestExpectation(description: "Wait for fetch completion")
    
    override func setUp() {
        super.setUp()
        UserDefaults.resetAll()
        interactor = TodosInteractor(network: mockNetwork, coreData: mockCoreData)
        interactor?.output = mockOutput
        mockOutput.onDidFetch = {
            self.expectation.fulfill()
        }
    }
    
    override func tearDown() {
        interactor = nil
        super.tearDown()
    }
    
    func test_fetchFromApi() {
        // given
        interactor?.isTodosLoadedFirstTime = false
        let apiTodos = [
            TodoApi(id: 1, todo: "Todo 1", completed: false, userId: 1),
            TodoApi(id: 2, todo: "Todo 2", completed: true, userId: 2)
        ]
        let count = apiTodos.count
        let response = TodosResponse(todos: apiTodos)
        mockNetwork.todosResult = .success(response)
        
        // when
        interactor?.fetch()
        wait(for: [expectation], timeout: 1.0)
        
        // then
        //проверили, что данные загружаются из API
        XCTAssertTrue(mockNetwork.getTodosCalled)
        XCTAssertFalse(mockCoreData.fetchCalled)
        
        //проверили что данные из API сохранились в CoreData
        XCTAssertTrue(mockCoreData.savedLoaded.count == count)
        
        //проверили, что после загрузки и сохранения данных, данные отдаем в презентер
        XCTAssertTrue(mockOutput.didFetchCalled)
        XCTAssertEqual(mockOutput.fetchedTodos.count, count)
        XCTAssertEqual(mockOutput.fetchedTodos[0].todo, apiTodos[0].todo)
    }
    
    func test_fetchFromCoreData() {
        // given
        interactor?.isTodosLoadedFirstTime = true
        
        // when
        interactor?.fetch()
        wait(for: [expectation], timeout: 1.0)
        
        // then
        //проверили что данные загрузили из CoreData
        XCTAssertFalse(mockNetwork.getTodosCalled)
        XCTAssertTrue(mockCoreData.fetchCalled)
        
        //проверили, что после загрузки и сохранения данных, данные отдаем в презентер
        XCTAssertTrue(mockOutput.didFetchCalled)
        XCTAssertFalse(mockOutput.fetchedTodos.isEmpty)
        let todo = mockCoreData.mockEntities[0].todo
        XCTAssertEqual(mockOutput.fetchedTodos[0].todo, todo)
    }
    
    func test_delete() {
        // given
        interactor?.isTodosLoadedFirstTime = true
        let id = UUID()
        
        // when
        interactor?.delete(id: id)
        wait(for: [expectation], timeout: 1.0)
        
        // then
        //проверили что вызвалось удаление
        XCTAssertTrue(mockCoreData.deleteCalled)
        //проверили что после удаление обновили данные
        XCTAssertTrue(mockCoreData.fetchCalled)
        XCTAssertTrue(mockOutput.didFetchCalled)
    }
    
    func test_searchWithText() {
        // given
        interactor?.isTodosLoadedFirstTime = true
        let text = "text"
        
        // when
        interactor?.search(text: text)
        wait(for: [expectation], timeout: 1.0)
        
        // then
        //проверили что вызвался поиск
        XCTAssertTrue(mockCoreData.searchCalled)
        //проверили что после поиска обновили данные и данные содержат текст поиска
        XCTAssertTrue(mockOutput.didFetchCalled)
        if let searchedText = mockOutput.fetchedTodos.first?.title {
            XCTAssertTrue(
                searchedText.lowercased().contains(text.lowercased())
            )
        }
    }
}
