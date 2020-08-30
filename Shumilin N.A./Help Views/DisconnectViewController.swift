//
//  DisconnectViewController.swift
//  Shumilin N.A.
//
//  Created by Nikita Shumilin on 30.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import UIKit

protocol DisconnectViewControllerDelegate: AnyObject {
    func reconnectToServer()
}

class DisconnectViewController: UIViewController {

    weak var delegate: DisconnectViewControllerDelegate?
    
    // MARK: UI
    private let disconnectLabel: UILabel = {
        let label = UILabel()
        label.text = ":("
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let disconnectTextLabel: UILabel = {
        let label = UILabel()
        label.text = "No connection to server"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var disconnectStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.disconnectLabel, self.disconnectTextLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var reconnectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reconnect", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setTargets()
        setConstraints()
    }
}

// MARK: - Targets
extension DisconnectViewController {
    private func setTargets() {
        reconnectButton.addTarget(self, action: #selector(reconnectButtonAction), for: .touchUpInside)
    }
    
    @objc private func reconnectButtonAction() {
        delegate?.reconnectToServer()
    }
}

// MARK: - Constraints
extension DisconnectViewController {
    private func setConstraints() {
        setDisconnectStackView()
        setReconnectButton()
    }
    
    private func setDisconnectStackView() {
        self.view.addSubview(disconnectStackView)
        
        disconnectStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            disconnectStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            disconnectStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setReconnectButton() {
        self.view.addSubview(reconnectButton)
        
        reconnectButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reconnectButton.topAnchor.constraint(equalTo: disconnectStackView.bottomAnchor, constant: 32),
            reconnectButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            reconnectButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }
}
