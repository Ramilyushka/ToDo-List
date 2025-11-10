//
//  BaseView.swift
//  ToDo-List
//
//  Created by Ramilia on 05/11/25.
//
import UIKit

open class BaseView: UIView {
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupSubViews()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupSubViews() {
        //For override
    }
}
