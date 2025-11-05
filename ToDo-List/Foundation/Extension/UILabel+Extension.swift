//
//  UILabel+Extension.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//

import UIKit

extension UILabel {
    public convenience init(
        font: Font? = .caption,
        textColor: UIColor? = Color.white.color,
        opacity: CGFloat = 1,
        numberOfLines: Int = .zero,
        textAlignment: NSTextAlignment = .left
    ) {
        self.init(frame: .zero)
        self.font = font?.font
        self.textColor = textColor?.withAlphaComponent(opacity)
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
    
    func setStrikethrough(_ active: Bool) {
         guard let text = text else { return }
         if active {
             attributedText = NSAttributedString(
                 string: text,
                 attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
             )
         } else {
             attributedText = nil
             self.text = text
         }
     }
}
