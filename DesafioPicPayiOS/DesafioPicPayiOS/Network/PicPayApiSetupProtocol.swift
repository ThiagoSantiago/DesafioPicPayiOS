//
//  PicPayApiSetupProtocol.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}

protocol PicPayApiSetupProtocol {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : Any] { get }
    var headers: [String : String] { get }
}

extension PicPayApiSetupProtocol {
    var headers: [String : String] {
        return [:]
    }
    
    var parameters: [String : Any] {
        return [:]
    }
}
