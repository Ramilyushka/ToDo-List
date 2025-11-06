//
//  TodoDetailAssembly.swift
//  ToDo-List
//
//  Created by Ramilia on 07/11/25.
//
import UIKit

enum TodoDetailAssembly {
    static func make(with form: TodoDetailView.Form) -> UIViewController {
        //Interactor
        let coreData = TodosCoreData()
        let interactor = TodoDetailInteractor(coreData: coreData)
        
        //Presenter
        let router = TodoDetailRouter()
        let presenter = TodoDetailPresenter(form: form, interactor: interactor, router: router)
        interactor.output = presenter
        
        //View
        let view = TodoDetailViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        
        return view
    }
}
