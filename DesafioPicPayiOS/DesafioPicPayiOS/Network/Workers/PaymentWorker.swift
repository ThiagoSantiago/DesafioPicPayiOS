//
//  TransferWorker.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/13/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation


class PaymentWorker {
    typealias Failure = (_ error: PicPayApiError) -> Void
    
    let requester: PicPayApiRequestProtocol
 
    init(requester: PicPayApiRequestProtocol = PicPayApiRequest()) {
        self.requester = requester
    }
    
    
    typealias MakeAPaymentSuccess = () -> Void
    func makeAPayment(success: @escaping MakeAPaymentSuccess, failure: @escaping Failure) {
        
        requester.request(PicPayPaymentServiceSetup.makeAPayment()) { result in
            switch result{
            case let .success(data):
                
                do {
                    let decoder = JSONDecoder()
                    success()
                } catch {
                    failure(.couldNotParseObject)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
