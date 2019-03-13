//
//  NewCardViewController.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class NewCardViewController: UIViewController {
    
    @IBOutlet weak var registerCardButton: UIButton!
    
    init() {
        super.init(nibName: "NewCardViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCardButton.layer.cornerRadius = 25
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        AppRouter.shared.popViewController()
    }
    
    @IBAction func registerNewCardPressed(_ sender: Any) {
        AppRouter.shared.routeToHome()
    }
}
