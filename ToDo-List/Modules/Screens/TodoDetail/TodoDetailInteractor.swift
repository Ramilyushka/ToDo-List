//
//  TodoDetailInteractor.swift
//  ToDo-List
//
//  Created by Ramilia on 07/11/25.
//

import Foundation

protocol TodoDetailInteractorProtocol: AnyObject {
    func update()
    func save(title: String?, todo: String?)
}

protocol TodoDetailOutputProtocol: AnyObject {
    func didUpdate(with form: TodoDetailView.Form)
    func didSave()
}

final class TodoDetailInteractor: TodoDetailInteractorProtocol {
    // MARK: - Properties
    private let coreData: TodosCoreDataProtocol
    private let form: TodoDetailView.Form
    weak var output: TodoDetailOutputProtocol?
    
    // MARK: - Init
    init(form: TodoDetailView.Form, coreData: TodosCoreDataProtocol) {
        self.form = form
        self.coreData = coreData
    }
    
    // MARK: - TodosInteractorProtocol
    func update() {
        DispatchQueue.main.async {  [weak self] in
            guard let self = self else { return }
            output?.didUpdate(with: form)
        }
    }
    
    func save(title: String?, todo: String?) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if let title, let todo {
                var new: TodoViewModel
                switch form {
                case .new:
                    new = TodoViewModel(id: UUID(), title: title, todo: todo, date: Date(), completed: false)
                case .edit(let old):
                    new = TodoViewModel(id: old.id, title: title, todo: todo, date: old.date, completed: old.completed)
                }
                coreData.save(new)
                DispatchQueue.main.async {
                    self.output?.didSave()
                }
            } else {
                // TODO: PopUpMessage or подсказки
            }
        }
    }
}
