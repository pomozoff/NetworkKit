//
//  NetworkError.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import CommonKit
import Foundation

public enum NetworkErrorCode: BaseErrorCode {
    case authRequired(URLRequest)
    case accessDenied(URLRequest)
    case invalidUrl(String)
    case emptyData(URLRequest)
    case invalidRequest(URLRequest)
    case invalidResponse(URLRequest, URLResponse?)
    case internalError(URLRequest)

    public var rawValue: Int {
        switch self {
        case .authRequired: return 0
        case .accessDenied: return 1
        case .invalidUrl: return 2
        case .emptyData: return 3
        case .invalidRequest: return 4
        case .invalidResponse: return 5
        case .internalError: return 6
        }
    }

    public var localizedDescription: String {
        switch self {
        case let .authRequired(request): return "Authentication required, request: \(request)"
        case let .accessDenied(request): return "Access denied, request: \(request)"
        case let .invalidUrl(urlString): return "Invalid URL: \(urlString)"
        case let .emptyData(request): return "No data received, request: \(request)"
        case let .invalidRequest(request): return "Invalid request: \(request)"
        case let .invalidResponse(request, response): return "Invalid response: \(String(describing: response)), on the request: \(request)"
        case let .internalError(request): return "Internal error, request: \(request)"
        }
    }

    public init?(rawValue: Int) {
        return nil
    }
}

public class NetworkError: BaseError<NetworkErrorCode> {
    public override var domainShortName: String { "NW" }
}
