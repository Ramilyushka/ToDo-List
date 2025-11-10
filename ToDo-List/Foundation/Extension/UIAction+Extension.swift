//
//  UIAction+Extension.swift
//  ToDo-List
//
//  Created by Ramilia on 06/11/25.
//
import UIKit

extension UIAction {
    public struct Model {
        let title: String
        let image: UIImage?
        let attributes: UIMenuElement.Attributes
        
        init(title: String, image: UIImage? = nil, attributes: UIAction.Attributes = []) {
            self.title = title
            self.image = image
            self.attributes = attributes
        }
    }

    public enum Template {
        case edit
        case share
        case delete
        
        var value: Model {
            switch self {
            case .edit:
                    .init(title: "Редактировать", image: UIImage(named: "edit")?.withTintColor(.appWhite, renderingMode: .alwaysOriginal))
            case .share:
                    .init(title: "Поделиться", image: UIImage(named: "export")?.withTintColor(.appWhite, renderingMode: .alwaysOriginal), attributes: .disabled)
            case .delete:
                    .init(title: "Удалить", image: UIImage(named: "trash")?.withTintColor(.appRed, renderingMode: .alwaysOriginal), attributes: .destructive)
            }
        }
    }
    
    convenience init(_ template: Template, handler: @escaping UIActionHandler) {
        self.init(
            title: template.value.title,
            image: template.value.image,
            identifier: nil,
            discoverabilityTitle: nil,
            attributes: template.value.attributes,
            state: .off,
            handler: handler
        )
    }
}
