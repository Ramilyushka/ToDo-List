//
//  MockTodosPresenter.swift
//  ToDo-List
//
//  Created by Ramilia on 10/11/25.
//
@testable import ToDo_List

final class MockTodosPresenter: TodosPresenterProtocol {
    var countText: String = ""
    
    func viewDidLoad() {
      //  <#code#>
    }
    
    func getNumberOfRows() -> Int {
      return 1
    }
    
    func getTodoEntity(index: Int) -> ToDo_List.TodoViewModel {
        return .empty
    }
    
    func delete(index: Int) {
      //  <#code#>
    }
    
    func add() {
      //  <#code#>
    }
    
    func edit(index: Int) {
       // <#code#>
    }
    
    func search(text: String?) {
       // <#code#>
    }
}
