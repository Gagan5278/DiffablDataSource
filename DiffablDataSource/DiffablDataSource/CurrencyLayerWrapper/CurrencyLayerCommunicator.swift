//
//  CurrencyLayerCommunicator.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
class CurrencyLayerCommunicator: NetworkAPI {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    public convenience init() {
      self.init(configuration: .default)
    }
    
    
    //MARK:- Call service to get response
    private func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping(Result<T, NetworkError>) -> Void) {
        fetch(with: request, decode: { json -> T? in
            guard let resource = json as? T else { return nil }
            return resource
        }, completion: completionHandler)
    }
    
    
    //MARK:-
    public func get<T: ItemList> (_ value: T.Type, completion: @escaping (Result<T?, NetworkError>) -> Void) {
        let resource = CurrencyLayerEndPoint(key: Constants.access_key)
        self.fetch(request: resource.request, completionHandler: completion)
    }    
}
