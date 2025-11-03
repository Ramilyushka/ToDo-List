//
//  Colors.swift
//  ToDo-List
//
//  Created by Ramilia on 03/11/25.
//
import UIKit

public enum Colors {
    case black
    case white
    case yellow
    case stroke
    case gray
    case red
    
    public var color: UIColor {
        switch self {
        case .black:
            return .black
        case .white:
            return .white
        case .yellow:
            return .systemYellow
        case .stroke:
            return .systemGray2
        case .gray:
            return .systemGray
        case .red:
            return .systemRed
        }
    }
    
//    public var color: UIColor {
//        switch self {
//        case .black:
//           return color(from: "#040404")
//        case .white:
//            return color(from: "#F4F4F4")
//        case .yellow:
//            return color(from: "#FED702")
//        case .stroke:
//            return color(from: "#4D555E")
//        case .gray:
//            return color(from: "#272729")
//        case .red:
//            return color(from: "#D70015")
//        }
//    }
//    
//    private func color(from hex: String) -> UIColor {
//        var rgbValue:UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&rgbValue)
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
}
