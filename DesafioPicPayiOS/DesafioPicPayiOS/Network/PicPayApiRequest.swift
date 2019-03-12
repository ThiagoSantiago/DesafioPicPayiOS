//
//  PicPayApiRequest.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation


enum Result<T> {
    case success(T)
    case failure(PicPayApiError)
}

protocol PicPayApiRequestProtocol {
    func request(_ request: PicPayApiSetupProtocol, completion: @escaping (Result<Data>) -> Void)
}

class PicPayApiRequest: PicPayApiRequestProtocol {
    
    func request(_ request: PicPayApiSetupProtocol, completion: @escaping (Result<Data>) -> Void) {
        
        guard let urlRequest = URL(string: request.endpoint) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
            }
            
            guard let data = data else {
                completion(.failure(.brokenData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknown("Could not cast to HTTPURLResponse object.")))
                return
            }
            
            completion(self.handler(statusCode: httpResponse.statusCode, dataResponse: data))
            
            }.resume()
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
}
