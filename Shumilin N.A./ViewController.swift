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
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    
    @IBOutlet weak var companyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
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
                return
            }
            self.companies = unwrapCompanies
            
            DispatchQueue.main.async {
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
                return
            }
            
            DispatchQueue.main.async {
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
        activityIndicator.stopAnimating()
        companyNameLabel.text = companyName
        symbolLabel.text = symbol
        priceLabel.text = "\(price) $"
        priceChangeLabel.text = "\(priceChange) $"
    }
    
    private func requestQuoteUpdate() {
        activityIndicator.startAnimating()
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
