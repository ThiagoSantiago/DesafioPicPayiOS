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
    
    var viewModel: UserViewModel?
    
    init(viewModel: UserViewModel) {
        super.init(nibName: "NewCardViewController", bundle: Bundle.main)
        self.viewModel = viewModel
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
        guard let userViewModel = viewModel else { return }
        AppRouter.shared.routeToRegisterNewCard(viewModel: PaymentViewModel(card: nil, value: nil, destinationUser: userViewModel))
    }
}
