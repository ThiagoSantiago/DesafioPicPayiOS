//
//  PicPayApiRequestMock.swift
//  DesafioPicPayiOSTests
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation
@testable import DesafioPicPayiOS

enum ServiceFailure {
    case badUrl
    case dataError
    case unknownError
    case responseError
}

class PicPayApiRequestMock: PicPayApiRequest {
    var isFailure = false
    var failureType: ServiceFailure = .unknownError
    var statusCode = 200
    var jsonData: String = ""
    
    override func request(_ request: PicPayApiSetupProtocol, completion: @escaping (Result<Data>) -> Void) {
        
        if isFailure {
            completion(self.handleError(type: failureType))
        } else {
            guard let data = getData() else {
                return completion(.failure(.brokenData))
            }
            
            completion(self.handler(statusCode: statusCode, dataResponse: data))
        }
    }
    
    private func handler(statusCode: Int, dataResponse: Data) -> Result<Data> {
        
        switch statusCode {
        case 200...299:
            return Result.success(dataResponse)
        case 403:
            return Result.failure(.authenticationRequired)
            
        case 404:
            return Result.failure(.couldNotFindHost)
            
        case 500:
            return Result.failure(.badRequest)
            
        default: return Result.failure(.unknown(""))
        }
    }
    
    private func handleError(type: ServiceFailure) -> Result<Data> {
        switch failureType {
        case .badUrl:
            let badUrl: URL? = nil
            
            guard let _ = badUrl else {
                return Result.failure(.badUrl)
                
            }
            
        case .dataError:
            guard let _ = getData(failure: isFailure) else {
                return Result.failure(.brokenData)
            }
            
        case .unknownError:
            let unknowError: PicPayApiError? = PicPayApiError.unknown("")
            
            if let error = unknowError {
                return Result.failure(.unknown(error.localizedDescription))
            }
            
        case .responseError:
            let response: URLResponse? = nil
            
            guard let _ = response as? HTTPURLResponse else {
                return Result.failure(.unknown("Could not cast to HTTPURLResponse object."))
            }
        }
        
        return Result.failure(.unknown(""))
    }
    
    private func getData(failure: Bool = false) -> Data? {
        
        if failure {
            jsonData = "test"
        }
        
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: jsonData, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                return data
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
