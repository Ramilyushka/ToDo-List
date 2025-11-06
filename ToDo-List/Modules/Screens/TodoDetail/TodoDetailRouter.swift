//
//  TodoDetailRouter.swift
//  ToDo-List
//
//  Created by Ramilia on 07/11/25.
//
import UIKit

// MARK: - Notification
extension Notification.Name {
    static let todoSaved = Notification.Name("todoSaved")
}

// MARK: - TodoDetailRouter
protocol TodoDetailRouterProtocol {
    func close()
}

final class TodoDetailRouter: TodoDetailRouterProtocol {
    weak var view: UIViewController?
     
     func close() {
         view?.navigationController?.popViewController(animated: true)
         NotificationCenter.default.post(name: .todoSaved, object: nil)
     }
}
