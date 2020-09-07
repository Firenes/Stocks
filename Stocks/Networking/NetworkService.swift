//
//  NetworkService.swift
//  Stocks
//
//  Created by Nikita Shumilin on 29.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import Foundation

class NetworkService {
    func request(urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Failed URL")
            completion(.failure(.badURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.requestProblem))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completion(.failure(.responseProblem))
                return
            }
            
            if statusCode != 200 {
                let responseCheck = self.responseCheck(statusCode: statusCode)
                completion(.failure(responseCheck))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        
        dataTask.resume()
    }
    
    private func responseCheck(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 400:
            return .requestProblem
        case 401..<404:
            return .badURL
        case 404:
            return .notFound
        case 500:
            return .serverProblem
        default:
            return .unknownError
        }
    }
}
