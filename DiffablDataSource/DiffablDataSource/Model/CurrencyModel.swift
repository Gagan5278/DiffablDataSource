//
//  CurrencyModel.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
struct ExchangeRate: Hashable {
    let fxPair: String
    let rate: Double
    var isSelectedItem: Bool = false
}
/****************************WIP*****************************

//MARK:- Save Struct
extension ExchangeRate {
    func encode() -> Data {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        archiver.encode(fxPair, forKey: "fxPair")
        archiver.encode(isSelectedItem, forKey: "rate")
        archiver.encode(isSelectedItem, forKey: "isSelectedItem")
        archiver.finishEncoding()
        return data as Data
    }
    init?(data: Data) {
        do {
            let unarchiver = try NSKeyedUnarchiver(forReadingFrom:data)
            defer {
                unarchiver.finishDecoding()
            }
            guard let name = unarchiver.decodeObject(forKey: "fxPair") as? String else { return nil }
            guard let rate = unarchiver.decodeObject(forKey: "rate") as? Double else { return nil }
            let isSelectedItem = unarchiver.decodeBool(forKey: "isSelectedItem")
            self.fxPair = name
            self.rate = rate
            self.isSelectedItem = isSelectedItem
        }
        catch {
            self.fxPair = ""
            self.rate = 0.0
            self.isSelectedItem = false
        }
    }
}
 ****************************WIP*****************************/

struct CurrencyModel: Decodable {
    var exchangeRates = [ExchangeRate]()
    init(from decoder: Decoder) throws {
        //1.  Craete an object of ExchangeRate and append in array
        let container = try decoder.singleValueContainer()
        let dict = try container.decode([String: Double].self)
        exchangeRates = dict.map { ExchangeRate(fxPair: String($0.key.dropFirst(3)), rate: $0.value)}
        //2. Sorting by name
        exchangeRates = exchangeRates.sorted { (e1, e2) -> Bool in
            return e1.fxPair < e2.fxPair
        }
    }
}
