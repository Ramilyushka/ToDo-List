//
//  UserDefaultsStorage.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//
import Foundation

public enum UserDefaultsStorageKey: String {
    case isTodosLoadedFirstTime
}

@propertyWrapper
public struct UserDefaultsStorage<T> {
    private let key: String
    private let userDefaults = UserDefaults.standard

    public init(_ key: UserDefaultsStorageKey) {
        self.key = key.rawValue
    }

    public var wrappedValue: T? {
        get {
            getValue()
        }
        set {
            setValue(newValue)
        }
    }

    private func getValue() -> T? {
        userDefaults.object(forKey: key) as? T
    }

    private func setValue(_ value: T?) {
        userDefaults.setValue(value, forKey: key)
    }
}
