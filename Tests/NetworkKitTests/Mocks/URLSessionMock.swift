//
//  File.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?

    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        URLSessionDataTaskMock { [data, response, error] in
            completionHandler(data, response, error)
        }
    }
}
