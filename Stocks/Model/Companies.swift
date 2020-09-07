//
//  Companies.swift
//  Stocks
//
//  Created by Nikita Shumilin on 29.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import Foundation

struct Companies {
    var companyName: String?
    var symbol: String?
}

extension Companies: Codable {
    enum CodingKeys: String, CodingKey {
        case companyName
        case symbol
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(companyName, forKey: .companyName)
        try container.encode(symbol, forKey: .symbol)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        companyName = try? container.decode(String.self, forKey: .companyName)
        symbol = try? container.decode(String.self, forKey: .symbol)
    }
}
