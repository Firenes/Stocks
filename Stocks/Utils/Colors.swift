//
//  Colors.swift
//  Stocks
//
//  Created by Nikita Shumilin on 30.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import UIKit

enum Colors {
    case green
}

extension Colors {
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .green:
            instanceColor = UIColor(red: 0.0/255.0, green: 187.0/255.0, blue: 9.0/255.0, alpha: 1)
        }
        
        return instanceColor
    }
}
