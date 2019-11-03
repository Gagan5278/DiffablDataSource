//
//  Resource.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct Resource<T: Decodable>: ItemList {
    var success: Bool
    var terms: String
    var privacy: String
    var timestamp: Int
    var source: String
    var quotes: T
}

protocol ItemList: Decodable {
    associatedtype T
    var success: Bool {get}
    var terms: String {get}
    var privacy: String {get}
    var timestamp: Int {get}
    var source: String {get}
    var quotes: T {get}
}



