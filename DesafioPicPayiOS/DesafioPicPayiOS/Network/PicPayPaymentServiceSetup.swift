//
//  PicPayTransferServiceSetup.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/13/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum PicPayPaymentServiceSetup: PicPayApiSetupProtocol {
    
    case makeAPayment()
    
    var endpoint: String {
        switch self {
            
        case .makeAPayment():
            let url = Constants.baseUrl+"/tests/mobdev/transaction"
            
            return url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .makeAPayment():
            return .post
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .makeAPayment():
            return ["card_number" : "1111111111111111",
                    "cvv" : 789,
                    "value" : 79.9,
                    "expiry_date" : "01/08",
                    "destination_user_id" : 1002]
        }
    }
}
