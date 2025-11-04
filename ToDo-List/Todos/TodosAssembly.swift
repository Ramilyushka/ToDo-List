//
//  TodosAssembly.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//

enum TodosAssembly {
    static func make() -> TodosViewController {
        let network = TodosNetwork()
        let presenter = TodosPresenter(network: network)
        let view = TodosViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
