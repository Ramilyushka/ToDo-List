//
//  Colors.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//
import UIKit

public extension UIColor {
    static let appBlack = UIColor(hex: "#040404")
    static let appWhite = UIColor(hex: "#F4F4F4")
    static let appWhite50 = UIColor(hex: "#F4F4F4").withAlphaComponent(0.5)
    static let appYellow = UIColor(hex: "#FED702")
    static let appStroke = UIColor(hex: "#4D555E")
    static let appGray = UIColor(hex: "#272729")
    static let appRed = UIColor(hex: "#D70015")
    
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}
