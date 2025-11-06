//
//  TodosRouter.swift
//  ToDo-List
//
//  Created by Ramilia on 06/11/25.
//

import UIKit

protocol TodosRouterProtocol {
    func navigateToTodoDetail(with form: TodoDetailView.Form)
}

class TodosRouter: TodosRouterProtocol {
    weak var view: UIViewController?
    
    func navigateToTodoDetail(with form: TodoDetailView.Form) {
        let detailView = TodoDetailViewController(todoForm: form)
        view?.navigationController?.pushViewController(detailView, animated: true)
    }
}
