//
//  TodosAssembly.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//

import UIKit

enum TodosAssembly {
    static func make() -> UIViewController {
        //Interactor
        let network = TodosNetwork()
        let coreData = TodosCoreData()
        let interactor = TodosInteractor(network: network, coreData: coreData)
        
        //Presenter
        let router = TodosRouter()
        let presenter = TodosPresenter(interactor: interactor, router: router)
        interactor.output = presenter
        
        //View
        let view = TodosViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        
        return UINavigationController(rootViewController: view)
    }
}
