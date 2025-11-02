//
//  Fonts.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//

import UIKit

public enum Font {
    case button
    case caption
    
    var font: UIFont {
        switch self {
        case .button:
            UIFont.systemFont(ofSize: 16, weight: .medium)
        case .caption:
            UIFont.systemFont(ofSize: 12, weight: .regular)
        }
    }
}
