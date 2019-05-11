//
//  ViewController.swift
//  SwiftyMoneyExampleApp
//
//  Created by Krystian Kopeć on 07/05/2019.
//  Copyright © 2019 kr.kopec. All rights reserved.
//

import UIKit
import SwiftyMoney

class ViewController: UIViewController {

    @IBOutlet weak var sourceAmountTextfield: UITextField!
    @IBOutlet weak var sourceCurrencyTextfield: UITextField!
    @IBOutlet weak var targetCurrencyTextfield: UITextField!
    @IBOutlet weak var targetAmountTextfield: UITextField!
    @IBOutlet weak var localeTextfield: UITextField!

    @IBAction func convertButtonTapped(_ sender: Any) {
        convertSourceAmountToTargetAmount()
    }

    private let sourceCurrencyPicker = UIPickerView()
    private let targetCurrencyPicker = UIPickerView()
    private let localePicker = UIPickerView()

    private let currencies: [Currency] = [.euro,
                                          .polishZloty,
                                          .poundSterling,
                                          .swedishKrona,
                                          .usDollar]
    
    private let locales = [Locale(identifier: "en"),
                           Locale(identifier: "es"),
                           Locale(identifier: "fr"),
                           Locale(identifier: "pl")]

    private var sourceCurrency: Currency? = nil {
        didSet {
            sourceCurrencyTextfield.text = sourceCurrency?.code
        }
    }

    private var targetCurrency: Currency? = nil {
        didSet {
            targetCurrencyTextfield.text = targetCurrency?.code
        }
    }

    private var currentLocale: Locale? = nil {
        didSet {
            localeTextfield.text = currentLocale?.languageCode
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMoneyCurrencyConverter()
        setupPickerViews()
        insertDummyData()
        hideKeyboardWhenTappedAround()
    }

    // set up Money's default currency converter so that it is possible to convert money amount directly on a Money instance, as seen in the convertSourceAmountToTargetAmount method
    private func setupMoneyCurrencyConverter() {

        guard let ratesPackage = loadPlistData() else {
            return
        }
        let conversionRates = extractConversionRates(from: ratesPackage)
        Money.setCurrencyConverter(to: CurrencyConverter(baseCurrency: .euro,
                                                         currencyExchangeRates: conversionRates))
    }

    // load currency conversion rates from a property list file
    private func loadPlistData() -> CurrencyExchangeRatePackage? {

        guard let filePath = Bundle.main.path(forResource: "rates", ofType: "plist") else {
            return nil
        }

        let plistFileUrl = URL(fileURLWithPath: filePath)
        guard let ratesPackage = PropertyListLoader().load(plistUrl: plistFileUrl,
                                                           as: CurrencyExchangeRatePackage.self)
        else {
            return nil
        }
        return ratesPackage
    }

    // compare available currencies and extract currency conversion rates used for these currencies
    private func extractConversionRates(from ratesPackage: CurrencyExchangeRatePackage) -> Set<CurrencyExchangeRate> {

        guard let baseCurrency = self.currencies.first(where: { $0.code == ratesPackage.baseCurrencyCode}) else {
            return []
        }

        var conversionRates: Set<CurrencyExchangeRate> = []

        currencies.forEach { currency in
            if let matchingRate = ratesPackage.rates[currency.code] {
                let conversionRate = CurrencyExchangeRate(sourceCurrency: baseCurrency,
                                                          targetCurrency: currency,
                                                          allowsInverseConversion: true,
                                                          sourceToTargetRate: Decimal(matchingRate))
                conversionRates.insert(conversionRate)
            }
        }
        
        return conversionRates
    }

    private func setupPickerViews() {

        sourceCurrencyPicker.delegate = self
        sourceCurrencyPicker.dataSource = self
        sourceCurrencyTextfield.inputView = sourceCurrencyPicker

        targetCurrencyPicker.delegate = self
        targetCurrencyPicker.dataSource = self
        targetCurrencyTextfield.inputView = targetCurrencyPicker

        localePicker.delegate = self
        localePicker.dataSource = self
        localeTextfield.inputView = localePicker
    }

    private func insertDummyData() {
        sourceAmountTextfield.text = "1"
        sourceCurrency = .euro
        targetCurrency = .polishZloty
        currentLocale = locales[0]
    }

    // This is where magic happens
    private func convertSourceAmountToTargetAmount() {

        guard let valueString = sourceAmountTextfield.text,
              let value = Double(valueString) else {
            return
        }

        guard let sourceCurrency = sourceCurrency else { return }
        let money = Money(value: value, currency: sourceCurrency)

        guard let targetCurrency = targetCurrency else { return }
        guard let convertedMoney = money.converted(to: targetCurrency) else { return }
        targetAmountTextfield.text = MoneyFormatter().shortString(from: convertedMoney,
                                                                  locale: currentLocale ?? Locale.current,
                                                                  style: .currency)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === sourceCurrencyPicker {
            return currencies.count
        } else if pickerView === targetCurrencyPicker {
            return currencies.count
        } else if pickerView === localePicker {
            return locales.count
        } else {
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView === sourceCurrencyPicker {
            return currencies[row].name
        } else if pickerView === targetCurrencyPicker {
            return currencies[row].name
        } else {
            return locales[row].languageCode
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView === sourceCurrencyPicker {
            sourceCurrency = currencies[row]
        } else if pickerView === targetCurrencyPicker {
            targetCurrency = currencies[row]
        } else if pickerView == localePicker {
            currentLocale = locales[row]
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
