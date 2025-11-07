//
//  FooterView.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//
import UIKit

final class TodoFooterView: BaseView {
    //MARK: - Properties
    private let tapHandler: (() -> Void)?
    private var text: String?
    
    //MARK: - UI Properties
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .appWhite
        label.font = .appFont(.footer)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.appYellow, for: .normal)
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "new"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    init(text: String? = nil, tapHandler: (() -> Void)? = nil) {
        self.text = text
        self.tapHandler = tapHandler
        super.init()
    }
    
    override func setupSubViews() {
        backgroundColor = .appGray
        addSubview(label)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.height),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        
        setText(text)
        
        if let _ = tapHandler {
            addSubview(button)
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: Constants.height),
                button.widthAnchor.constraint(equalToConstant: Constants.width),
                button.trailingAnchor.constraint(equalTo: trailingAnchor),
                button.topAnchor.constraint(equalTo: topAnchor),
                button.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            button.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        }
    }
    
    // MARK: - Private methods
    @objc private func touchUpInside() {
        tapHandler?()
    }
    
    // MARK: - Public methods
    public func setText(_ text: String?) {
        self.text = text
        label.text = text
    }
}

//MARK: - Constants
private extension TodoFooterView {
    enum Constants {
        static let height: CGFloat = 68
        static let width: CGFloat = 44
    }
}
