//
//  Date+Extension.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//
import Foundation

extension Date {
    var shortFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self)
    }
}
