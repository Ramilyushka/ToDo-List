//
//  Fonts.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//
import UIKit
extension UIFont {
    public enum AppFont {
        case header
        case button
        case caption
        case footer
    }
    
    public static func appFont(_ style: AppFont) -> UIFont {
        switch style {
        case .header:
            return UIFont.systemFont(ofSize: 34, weight: .bold)
        case .button:
            return UIFont.systemFont(ofSize: 16, weight: .medium)
        case .caption:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
        case .footer:
            return UIFont.systemFont(ofSize: 11, weight: .regular)
        }
    }
}
