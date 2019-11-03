//
//  CurrencyLayerEndPoint.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct CurrencyLayerEndPoint {
    let accessKey: String
}

extension CurrencyLayerEndPoint: Endpoint {
    
    init(key: String) {
        self.accessKey = key
    }
    
    var base: String {
        return "http://www.apilayer.net"
    }
    
    var path: String {
        return "/api/live?access_key=\(accessKey)&format=1"
    }
}
