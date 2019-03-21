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
    var interactor: RegisterCardInteractor?
    
    init(interactor: RegisterCardInteractor, viewModel: UserViewModel) {
        super.init(nibName: "NewCardViewController", bundle: Bundle.main)
        self.viewModel = viewModel
        self.interactor = interactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkExistingCard()
        registerCardButton.layer.cornerRadius = 25
    }
    
    private func checkExistingCard() {
        interactor?.loadCard()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        AppRouter.shared.popViewController()
    }
    
    @IBAction func registerNewCardPressed(_ sender: Any) {
        guard let userViewModel = viewModel else { return }
        AppRouter.shared.routeToRegisterNewCard(viewModel: PaymentViewModel(card: nil, value: nil, destinationUser: userViewModel))
    }
}

extension NewCardViewController: RegisterCardViewProtocol {
    func displayCardSaved(success: Bool) {}
    
    func displayCardRetrieved(card: Card) {
        if !card.cardNumber.isEmpty &&
            !card.expirationDate.isEmpty &&
            !card.owner.isEmpty &&
            !card.securityCode.isEmpty {
            
            guard let userViewModel = self.viewModel else { return }
            let viewModel = PaymentViewModel(card: card, value: nil, destinationUser: userViewModel)
            AppRouter.shared.routeToPayment(viewModel)
        }
    }
}
