//
//  TaskListRequest.swift
//  ToDo-List
//
//  Created by Ramilia on 04/11/25.
//

import Foundation

enum RequestConstants {
    static let baseURL = "https://dummyjson.com"
}

struct requestGetTodos: NetworkRequest {
    var httpMethod: HttpMethod { .get }
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/todos")
    }
}
