//
//  Parsable.swift
//  LeoCalc
//
//  Created by Anton Pomozov on 25.07.2021.
//

import Foundation

public protocol Parsable {
    func parse<T>(_ response: Response) throws -> T where T: Decodable
}
