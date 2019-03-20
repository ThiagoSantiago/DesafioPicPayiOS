//
//  PicPayTransferServiceSetup.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/13/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum PicPayPaymentServiceSetup: PicPayApiSetupProtocol {
    
    case makeAPayment(data: PaymentViewModel)
    
    var endpoint: String {
        switch self {
            
        case .makeAPayment(_):
            let url = Constants.baseUrl+"/tests/mobdev/transaction"
            
            return url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .makeAPayment(_):
            return .post
        }
    }
    
    var headers: [String : String] {
        return ["Content-Type":"application/json"]
    }
    
    var parameters: [String : Any] {
        switch self {
        case .makeAPayment(let paymentData):
            return ["card_number" : paymentData.cardNumber,
                    "cvv" : paymentData.securityCode,
                    "value" : paymentData.value,
                    "expiry_date" : paymentData.expiryDate,
                    "destination_user_id" : paymentData.destinationUser]
        }
    }
}
