//
//  File.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation
import NetworkKit

enum TestAPI {
    case featureList
    case newFeature(name: String)
    case deleteFeature(id: Int)
}

extension TestAPI: NetworkKit.Target {
    var baseURL: String { "https://example.com" }

    var path: String {
        switch self {
        case .featureList:
            return "/featureList"
        case let .newFeature(name):
            return "/newFeature?\(name)"
        case let .deleteFeature(id):
            return "/deleteFeature?\(id)"
        }
    }

    var method: NetworkKit.Method {
        switch self {
        case .featureList:
            return .get
        case .newFeature:
            return .post
        case .deleteFeature:
            return .put
        }
    }

    var headers: [String : String]? { nil }

    var task: NetworkKit.Task {
        switch self {
        case .featureList:
            return .requestPlain
        case let .newFeature(name):
            return .requestJSONEncodable(name)
        case let .deleteFeature(id):
            return .requestJSONEncodable(id)
        }
    }
}
