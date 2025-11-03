//
//  Checkbox.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//
import UIKit

final class CheckboxButton: UIButton {
    
    // MARK: - Properties
    private let icon = UIImage(named: "unchecked")
    private let iconSelected = UIImage(named: "checked")
    
    // MARK: - Override
    override var isSelected: Bool {
        didSet {
            updateImage()
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
        updateImage()
    }
    
    private func updateImage() {
        setImage(isSelected ? iconSelected : icon, for: .normal)
    }
    
    @objc private func toggle() {
        isSelected.toggle()
    }
}
