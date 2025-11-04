//
//  Fonts.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//

import UIKit

public enum Font {
    case header
    case button
    case caption
    case footer
    
    var font: UIFont {
        switch self {
        case .header:
            UIFont.systemFont(ofSize: 34, weight: .bold)
        case .button:
            UIFont.systemFont(ofSize: 16, weight: .medium)
        case .caption:
            UIFont.systemFont(ofSize: 12, weight: .regular)
        case .footer:
            UIFont.systemFont(ofSize: 11, weight: .regular)
        }
    }
}
