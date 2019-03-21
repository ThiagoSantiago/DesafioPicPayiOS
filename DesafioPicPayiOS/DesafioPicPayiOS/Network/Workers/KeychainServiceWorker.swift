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
    
    func saveCard(_ card: Card) -> Bool {
        let saveCardNumberSuccessful: Bool = KeychainWrapper.standard.set(card.cardNumber, forKey: "cardNumber")
        let saveSecurityCodeSuccessful: Bool = KeychainWrapper.standard.set(card.securityCode, forKey: "securityCode")
        let saveExpiryDateSuccessful: Bool = KeychainWrapper.standard.set(card.expirationDate, forKey: "expiryDate")
        let saveOwnerSuccessful: Bool = KeychainWrapper.standard.set(card.owner, forKey: "owner")
        
        return (saveCardNumberSuccessful &&
                saveSecurityCodeSuccessful &&
                saveExpiryDateSuccessful &&
                saveOwnerSuccessful)
    }
    
    func loadCard() -> Card {
        
        let cardNumberRetrieved: String = KeychainWrapper.standard.string(forKey: "cardNumber") ?? ""
        let securityCodeRetrieved: String = KeychainWrapper.standard.string(forKey: "securityCode") ?? ""
        let expiryDateRetrieved: String = KeychainWrapper.standard.string(forKey: "expiryDate") ?? ""
        let ownerRetrieved: String = KeychainWrapper.standard.string(forKey: "owner") ?? ""
        
        return Card(owner: ownerRetrieved, cardNumber: cardNumberRetrieved, securityCode: securityCodeRetrieved, expirationDate: expiryDateRetrieved)
    }
}
