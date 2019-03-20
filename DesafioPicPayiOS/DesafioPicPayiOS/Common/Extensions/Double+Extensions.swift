//
//  Double+Extensions.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/20/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

extension Double {
    
    func formatToCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "pt_BR")
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? "R$ --"
    }
}
