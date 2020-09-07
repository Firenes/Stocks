//
//  UIViewController+Extension.swift
//  Stocks
//
//  Created by Nikita Shumilin on 30.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(child: UIViewController, to container: UIView) {
        self.addChild(child)
        child.view.frame = container.bounds
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
