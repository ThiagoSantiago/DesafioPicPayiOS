//
//  PopupState.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/19/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

enum PopupState {
    case closed
    case open
}

extension PopupState {
    var opposite: PopupState {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}
