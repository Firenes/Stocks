//
//  SpinnerViewController.swift
//  Shumilin N.A.
//
//  Created by Nikita Shumilin on 30.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {

    // MARK: UI
    private let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.15)
        self.view.backgroundColor = .white

        setConstraints()
        configureSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        spinner.stopAnimating()
    }
}

// MARK: - Configure Spinner
extension SpinnerViewController {
    private func configureSpinner() {
        self.spinner.color = .lightGray
        self.spinner.hidesWhenStopped = true
    }
}

// MARK: - Constraints
extension SpinnerViewController {
    private func setConstraints() {
        setSpinner()
    }
    
    private func setSpinner() {
        self.view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}
