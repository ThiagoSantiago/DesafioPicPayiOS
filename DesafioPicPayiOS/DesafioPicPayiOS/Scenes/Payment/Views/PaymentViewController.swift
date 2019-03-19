//
//  PaymentViewController.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/14/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol PaymentViewProtocol: class {
    func hideLoadingView()
    func showLoadingView()
    func displaySucces(_ payment: TransactionViewModel)
    func displayError(message: String)
}

class PaymentViewController: BaseViewController {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var creditCard: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
//    var paymentData: PaymentViewModel?
    var interactor: PaymentInteractor?
    
    init(interactor: PaymentInteractor) {
        super.init(nibName: "PaymentViewController", bundle: Bundle.main)
        self.interactor = interactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    func configViews() {
        userImage.layer.cornerRadius = 20
        payButton.layer.cornerRadius = 25
    }
    
    @IBAction func editCreditCardPressed(_ sender: Any) {
        AppRouter.shared.routeToHome()
    }
    
    @IBAction func payButtonPressed(_ sender: Any) {
        interactor?.makeApayment()
    }
}

extension PaymentViewController: PaymentViewProtocol {
    func hideLoadingView() {
        self.hideLoader()
    }
    
    func showLoadingView() {
        self.showLoader()
    }
    
    func displaySucces(_ transaction: TransactionViewModel) {
        AppRouter.shared.popToHome(with: transaction)
    }
    
    func displayError(message: String) {
        // implement the error feedback
    }
}
