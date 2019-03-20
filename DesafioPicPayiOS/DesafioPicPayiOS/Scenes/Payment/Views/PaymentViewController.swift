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
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var bottonButtonConstraint: NSLayoutConstraint!
    
    var viewModel: PaymentViewModel?
    var interactor: PaymentInteractor?
    let service = "myService"
    
    init(interactor: PaymentInteractor, viewModel: PaymentViewModel) {
        super.init(nibName: "PaymentViewController", bundle: Bundle.main)
        self.viewModel = viewModel
        self.interactor = interactor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        valueTextField.becomeFirstResponder()
    }
    
    private func setup() {
        addNotificationsObserver()
    }
    
    private func configViews() {
        addGestures()
        
        userImage.layer.cornerRadius = 20
        payButton.layer.cornerRadius = 25
        
        valueTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func addGestures() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    private func addNotificationsObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.bottonButtonConstraint.constant = (keyboardSize.height) + payButton.bounds.height + 20
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
            self.bottonButtonConstraint.constant = 24
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        AppRouter.shared.popViewController()
    }
    
    @IBAction func editCreditCardPressed(_ sender: Any) {
        AppRouter.shared.routeToRegisterNewCard()
    }
    
    @IBAction func payButtonPressed(_ sender: Any) {
        if let paymentData = viewModel {
            interactor?.makeApayment(with: paymentData)
        }
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
        let alert = UIAlertController(title: "Payment Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
