//
//  NetworkError.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public enum NetworkError: Error {
    case authRequired
    case accessDenied
    case invalidUrl
    case emptyData
    case invalidRequest
    case invalidResponse
    case internalError
}
