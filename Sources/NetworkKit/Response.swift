//
//  Response.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public struct Response {
    public let request: URLRequest
    public let data: Data
    public let statusCode: Int
}
