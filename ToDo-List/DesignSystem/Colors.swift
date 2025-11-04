//
//  Colors.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//
import UIKit

public enum Color {
    case black
    case white
    case yellow
    case stroke
    case gray
    case red
    
//    public var color: UIColor {
//        switch self {
//        case .black:
//            return .black
//        case .white:
//            return .white
//        case .yellow:
//            return .systemYellow
//        case .stroke:
//            return .systemGray2
//        case .gray:
//            return .systemGray
//        case .red:
//            return .systemRed
//        }
//    }
    
    public var color: UIColor {
        switch self {
        case .black:
           return color(from: "#040404")
        case .white:
            return color(from: "#F4F4F4")
        case .yellow:
            return color(from: "#FED702")
        case .stroke:
            return color(from: "#4D555E")
        case .gray:
            return color(from: "#272729")
        case .red:
            return color(from: "#D70015")
        }
    }
    
    private func color(from hexString: String) -> UIColor {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        return UIColor(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha) / 255
        )
    }
}
