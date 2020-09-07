//
//  NetworkError.swift
//  Stocks
//
//  Created by Nikita Shumilin on 30.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case serverProblem
    case requestProblem
    case responseProblem
    case notFound
    case unknownError
}
