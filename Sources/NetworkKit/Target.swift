//
//  Target.swift
//
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public protocol Target {
    var url: URL? { get }
    var method: Method { get }
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var task: Task { get }
}

public extension Target {
    var url: URL? {
        guard var components = URLComponents(string: baseURL) else { return nil }
        components.path = path
        return components.url
    }
}
