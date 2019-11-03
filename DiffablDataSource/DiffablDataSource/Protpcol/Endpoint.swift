//
//  Endpoint.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String {get}
    var path: String {get}
}

extension Endpoint {
    var urlComponents: URLComponents {
        return URLComponents(string: base + path)!  //forced it to crash if there is no data
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
