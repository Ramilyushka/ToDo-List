//
//  UILabel+Extension.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//

import UIKit

extension UILabel {
    public convenience init(
        font: UIFont? = .appFont(.caption),
        textColor: UIColor? = .appWhite,
        numberOfLines: Int = .zero,
        textAlignment: NSTextAlignment = .left
    ) {
        self.init(frame: .zero)
        self.font = font
        self.textColor = textColor
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
