//
//  Provider.swift
//  
//
//  Created by Anton Pomozov on 15.07.2021.
//

import Foundation

public class Provider<T: Target> {
    public typealias NetworkResult = Result<Response, Error>

    public init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    public func request(_ target: T, completion: @escaping (NetworkResult) -> Void) {
        guard let url = target.url else {
            return completion(.failure(NetworkError.invalidUrl))
        }

        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers

        print(urlSession)
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                return completion(.failure(NetworkError.emptyData))
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.invalidResponse))
            }

            completion(.success(Response(data: data, statusCode: httpResponse.statusCode)))
        }
        dataTask.resume()
    }

    private let urlSession: URLSession
}
