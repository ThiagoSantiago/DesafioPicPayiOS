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
    
    typealias MakeAPaymentSuccess = (_ result: Payment) -> Void
    func makeAPayment(paymentData: PaymentViewModel, success: @escaping MakeAPaymentSuccess, failure: @escaping Failure) {
        
        requester.request(PicPayPaymentServiceSetup.makeAPayment(data: paymentData)) { result in
            switch result{
            case let .success(data):
                
                do {
                    let decoder = JSONDecoder()
                    let paymentData = try decoder.decode(Payment.self, from: data)
                    
                    if paymentData.transaction.success {
                        success(paymentData)
                    } else {
                        failure(.unknown("Operação recusada."))
                    }
                    
                } catch {
                    failure(.couldNotParseObject)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
