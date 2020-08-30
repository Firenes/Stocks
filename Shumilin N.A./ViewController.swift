//
//  ViewController.swift
//  Shumilin N.A.
//
//  Created by Nikita Shumilin on 29.08.2020.
//  Copyright © 2020 Nikita Shumilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let networkFetcher = NetworkDataFetcher()
    
    private var companies = [Companies]()
    
    // MARK: UI
    let disconnectVC = DisconnectViewController()
    let spinnerVC = SpinnerViewController()
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    @IBOutlet weak var companyPickerView: UIPickerView!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        disconnectVC.delegate = self
        
        self.add(child: spinnerVC, to: self.view)
        
        requestCompanies()
    }
}

// MARK: - Private Methods
extension ViewController {
    private func requestCompanies() {
        networkFetcher.fetchCompanies(limit: "100") { [weak self] (companies) in
            guard let self = self else { return }
            guard let unwrapCompanies = companies else {
                print("Sorry there are no companies data")
                DispatchQueue.main.async {
                    self.remove(child: self.spinnerVC)
                    self.add(child: self.disconnectVC, to: self.view)
                }
                return
            }
            self.companies = unwrapCompanies
            
            DispatchQueue.main.async {
                self.remove(child: self.disconnectVC)
                self.remove(child: self.spinnerVC)
                self.requestQuoteUpdate()
                
                self.companyPickerView.dataSource = self
                self.companyPickerView.delegate = self
            }
        }
    }
    
    private func requestQuote(for symbol: String) {
        networkFetcher.fetchQuotes(symbol: symbol) { [weak self] (quote) in
            guard let self = self else { return }
            
            guard
                let unwrQuote = quote,
                let companyName = unwrQuote.companyName,
                let symbol = unwrQuote.symbol,
                let price = unwrQuote.price,
                let priceChange = unwrQuote.priceChange
            else {
                print("Sorry there are no quote data")
                DispatchQueue.main.async {
                    self.add(child: self.disconnectVC, to: self.view)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.remove(child: self.disconnectVC)
                self.displayStockInfo(companyName: companyName,
                                      symbol: symbol,
                                      price: price,
                                      priceChange: priceChange)
            }
        }
    }
    
    private func displayStockInfo(companyName: String,
                                  symbol: String,
                                  price: Double,
                                  priceChange: Double) {
        self.remove(child: spinnerVC)
        companyNameLabel.text = companyName
        symbolLabel.text = symbol
        priceLabel.text = "\(price) $"
        priceChangeLabel.text = "\(priceChange) $"
    }
    
    private func requestQuoteUpdate() {
        self.add(child: spinnerVC, to: self.view)
        companyNameLabel.text = "-"
        symbolLabel.text = "-"
        priceLabel.text = "-"
        priceChangeLabel.text = "-"
        
        let selectedRow = companyPickerView.selectedRow(inComponent: 0)
        if !companies.isEmpty {
            guard let selectedSymbol = companies[selectedRow].symbol else { return }
            self.requestQuote(for: selectedSymbol)
        } else {
            print("Companies are empty")
        }
    }
}

// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return companies.count
    }
}

// MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return companies[row].companyName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestQuoteUpdate()
    }
}

extension ViewController: DisconnectViewControllerDelegate {
    func reconnectToServer() {
        print("reconnectToServer")
        disconnectVC.add(child: spinnerVC, to: disconnectVC.view)
        requestCompanies()
    }
}
