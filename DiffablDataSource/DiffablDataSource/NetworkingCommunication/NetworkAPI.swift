//
//  NetworkAPI.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

protocol NetworkAPI {
    var session: URLSession {get}
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping(Decodable) -> T?, completion:@escaping (Result<T, NetworkError>) -> Void)
}

extension NetworkAPI {    
    //1.
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping(Decodable) -> T?, completion:@escaping (Result<T, NetworkError>) -> Void)  {
        let task = self.decodeTask(with: request, decodingType: T.self) { (jsonModel, error) in
            DispatchQueue.main.async {
                guard let json = jsonModel else {
                    if let error =  error {
                        completion(.failure(error))
                    }
                    else {
                        completion(.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                }
                else {
                    completion(.failure(.parsingFailure))
                }
            }
        }
        task.resume()
    }
    
    //2.
    func decodeTask<T: Decodable> (with request: URLRequest, decodingType: T.Type, completionHandler:@escaping (Decodable?, NetworkError?) -> Void) -> URLSessionDataTask {
        let sessionDataTask = self.session.dataTask(with: request) { (data, response, error) in
            guard let data = data  else {
                completionHandler(nil, .invalidData)
                return
            }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(decodingType, from: data)
                completionHandler(model, nil)
            }
            catch {
                completionHandler(nil, .failedToConvertInJson(decription: error.localizedDescription))
            }
        }
        return sessionDataTask
    }
}
