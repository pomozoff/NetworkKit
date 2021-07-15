//
//  File.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }

    private let closure: () -> Void
}
