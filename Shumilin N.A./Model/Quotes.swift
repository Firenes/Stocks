//
//  Quotes.swift
//  Shumilin N.A.
//
//  Created by Nikita Shumilin on 29.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import Foundation

struct Quotes {
    var companyName: String?
    var symbol: String?
    var price: Double?
    var priceChange: Double?
}

extension Quotes: Codable {
    enum CodingKeys: String, CodingKey {
        case companyName
        case symbol
        case price = "latestPrice"
        case priceChange = "change"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(companyName, forKey: .companyName)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(price, forKey: .price)
        try container.encode(priceChange, forKey: .priceChange)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        companyName = try? container.decode(String.self, forKey: .companyName)
        symbol = try? container.decode(String.self, forKey: .symbol)
        price = try? container.decode(Double.self, forKey: .price)
        priceChange = try? container.decode(Double.self, forKey: .priceChange)
    }
}
