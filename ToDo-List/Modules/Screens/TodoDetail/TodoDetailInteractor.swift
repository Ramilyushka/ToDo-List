//
//  TodoDetailInteractor.swift
//  ToDo-List
//
//  Created by Ramilia on 07/11/25.
//

import Foundation

protocol TodoDetailInteractorProtocol: AnyObject {
    func save(_ todo: TodoViewModel)
}

protocol TodoDetailOutputProtocol: AnyObject {
    func didSave()
}

final class TodoDetailInteractor: TodoDetailInteractorProtocol {
    // MARK: - Properties
    private let coreData: TodosCoreDataProtocol
    weak var output: TodoDetailOutputProtocol?
    
    // MARK: - Init
    init(coreData: TodosCoreDataProtocol) {
        self.coreData = coreData
    }
    
    // MARK: - TodosInteractorProtocol
    func save(_ todo: TodoViewModel) {
        coreData.save(todo)
        output?.didSave()
    }
}
