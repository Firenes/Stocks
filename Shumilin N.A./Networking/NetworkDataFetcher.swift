//
//  NetworkDataFetcher.swift
//  Shumilin N.A.
//
//  Created by Nikita Shumilin on 29.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    let networkService = NetworkService()
    
    func fetchCompanies(limit: String, response: @escaping ([Companies]?) -> Void) {
        let urlString = "\(API.baseURL)/stock/market/list/mostactive?listLimit=\(limit)&token=\(API.token)"
        
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let companies = try JSONDecoder().decode([Companies].self, from: data)
                    response(companies)
                } catch let jsonError {
                    print("Failed with JSON companies: \(jsonError)")
                    response(nil)
                }
            case .failure(let error):
                print("Error companies: \(error)")
                response(nil)
            }
        }
    }
    
    func fetchQuotes(symbol: String, response: @escaping (Quotes?) -> Void) {
        let urlString = "\(API.baseURL)/stocks/\(symbol)/quote?=token=\(API.token)"
        
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let quote = try JSONDecoder().decode(Quotes.self, from: data)
                    response(quote)
                } catch let jsonError {
                    print("Failed with JSON quote: \(jsonError)")
                }
            case .failure(let error):
                print("Error quote: \(error)")
                response(nil)
            }
        }
    }
}
