//
//  CurrencyListViewModel.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/30.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

protocol  CurrencyConverterProtocol{
    var currencyName: String {get}
    var getSymbolForCurrencyCode: String? {get}
    var getCurrencyRate: Double {get}
    var myComputedProperty:Double {get set}
}

extension ExchangeRate: CurrencyConverterProtocol {

    public static var updatedcalculatedRate: Double = 1.0
    
    var myComputedProperty:Double {
        get {
            return ExchangeRate.updatedcalculatedRate
        }
        set(newValue) {
            ExchangeRate.updatedcalculatedRate = newValue
        }
    }
    
    var currencyName: String {
        return self.fxPair
    }
    
    var getCurrencyRate: Double {
        return self.rate*ExchangeRate.updatedcalculatedRate
    }
    
    var getSymbolForCurrencyCode: String? {
        let result = Locale.availableIdentifiers.map { Locale(identifier: $0) }.first { $0.currencyCode == self.fxPair }
        return result?.currencySymbol
    }
    
}

class CurrencyListViewModel {
    var showLoadingHud: Bindable = Bindable(false)
    let currencies = Bindable([CurrencyItemType]())
    var exchangeRates = [ExchangeRate]()
    //get all currencies from server
    func getAllCurrenciesAndExchangeRates() {
        self.showLoadingHud.value = true
        CurrencyLayerCommunicator().get(Resource<CurrencyModel>.self) {[weak self] (item) in
            self?.handleResult(item)
        }
    }
    
    private func handleResult<T>(_ result: Result<T, NetworkError>) {
        switch result {
        case .success(let value):
            let allValues = (value as! Resource<CurrencyModel>).quotes.exchangeRates
            guard !allValues.isEmpty else {
                self.currencies.value = [.empty]
                return
            }
            self.exchangeRates = allValues
            self.currencies.value = allValues.compactMap{ .normal(cellViewModel: $0 as CurrencyConverterProtocol)}
        case .failure(let err):
            self.currencies.value = [.error(message: err.localizedDescription)]
        }
        self.showLoadingHud.value = false
    }
}

enum CurrencyItemType {
    case normal(cellViewModel: CurrencyConverterProtocol)
    case error(message: String)
    case empty
}
