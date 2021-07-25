//
//  DefaultParser.swift
//  LeoCalc
//
//  Created by Anton Pomozov on 22.07.2021.
//

import Foundation

public class DefaultParser {
    public init() {}
}

extension DefaultParser: Parsable {
    public func parse<T>(_ response: Response) throws -> T where T: Decodable {
        switch response.statusCode {
        case 200 ..< 300:
            return try JSONDecoder().decode(T.self, from: response.data)

        case 401:
            throw NetworkError(code: .authRequired(response.request))

        case 403:
            throw NetworkError(code: .accessDenied(response.request))

        case 400 ..< 500:
            throw NetworkError(code: .invalidRequest(response.request))

        default:
            throw NetworkError(code: .internalError(response.request))
        }
    }
}
