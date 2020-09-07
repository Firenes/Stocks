//
//  UIImageView+Extension.swift
//  Stocks
//
//  Created by Nikita Shumilin on 30.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import UIKit

extension UIImageView {
    func download(imageURL: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: imageURL) else { return }
//            print(url.absoluteString)
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.image = nil
                    }
                }
            }
        }
    }
}
