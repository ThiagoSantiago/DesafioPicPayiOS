//
//  InstantPanGestureRecognizer.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/19/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
}
