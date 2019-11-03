//
//  NetworkError.swift
//  DiffablDataSource
//
//  Created by Gagan Vishal on 2019/10/29.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case failedRequest(decription: String)
    case failedToConvertInJson(decription: String)
    case invalidData
    case unsuccessfulResponse(decription: String)
    case parsingFailure
    
    var errorDescription: String {
        switch self {
        case .failedRequest(let desc):
            return "Request failed with error: \(desc)"
        case .failedToConvertInJson(let desc):
            return "Failed to convert into JSON with error: \(desc)"
        case .unsuccessfulResponse(let desc):
            return "Unable to get response with error: \(desc)"
        case .invalidData:
            return "Invalid data found from server"
        case .parsingFailure:
            return "Unable to parse response"
        }
    }
}
