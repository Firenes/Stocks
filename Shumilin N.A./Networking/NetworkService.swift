//
//  NetworkService.swift
//  Shumilin N.A.
//
//  Created by Nikita Shumilin on 29.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import Foundation

class NetworkService {
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Failed URL")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data,
                (response as? HTTPURLResponse)?.statusCode == 200 {
                completion(.success(data))
            }
        }
        
        dataTask.resume()
    }
}
