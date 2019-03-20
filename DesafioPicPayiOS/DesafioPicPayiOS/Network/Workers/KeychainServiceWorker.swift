//
//  KeychainService.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/13/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper


class KeychainServiceWorker: NSObject {
    
    let customKeychainWrapperInstance: KeychainWrapper?
    
    public override init() {
        customKeychainWrapperInstance = KeychainWrapper(serviceName: Constants.picPayCardService, accessGroup: Constants.picPayAccessGroup)
    }
    
    func saveCard(_ card: Card) -> Bool {
        let saveCardNumberSuccessful: Bool = customKeychainWrapperInstance?.set(card.cardNumber, forKey: "cardNumber") ?? false
        let saveSecurityCodeSuccessful: Bool = customKeychainWrapperInstance?.set(card.securityCode, forKey: "securityCode") ?? false
        let saveExpiryDateSuccessful: Bool = customKeychainWrapperInstance?.set(card.expirationDate, forKey: "expiryDate") ?? false
        let saveOwnerSuccessful: Bool = customKeychainWrapperInstance?.set(card.owner, forKey: "owner") ?? false
        
        return (saveCardNumberSuccessful &&
                saveSecurityCodeSuccessful &&
                saveExpiryDateSuccessful &&
                saveOwnerSuccessful)
    }
    
    func loadCard() -> Card {
        let cardNumberRetrieved: String = customKeychainWrapperInstance?.string(forKey: "cardNumber") ?? ""
        let securityCodeRetrieved: String = customKeychainWrapperInstance?.string(forKey: "securityCode") ?? ""
        let expiryDateRetrieved: String = customKeychainWrapperInstance?.string(forKey: "owner") ?? ""
        let ownerRetrieved: String = customKeychainWrapperInstance?.string(forKey: "owner") ?? ""
        
        return Card(owner: ownerRetrieved, cardNumber: cardNumberRetrieved, securityCode: securityCodeRetrieved, expirationDate: expiryDateRetrieved)
    }
}
