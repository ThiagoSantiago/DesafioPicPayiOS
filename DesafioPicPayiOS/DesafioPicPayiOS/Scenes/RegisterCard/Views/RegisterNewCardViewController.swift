//
//  RegisterNewCardViewController.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol RegisterCardViewProtocol: class {
    func displayCardSaved(success: Bool)
    func displayCardRetrieved(card: Card)
}

class RegisterNewCardViewController: UIViewController {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cardNumber: FloatingTextField!
    @IBOutlet weak var securityCode: FloatingTextField!
    @IBOutlet weak var cardOwnerName: FloatingTextField!
    @IBOutlet weak var expirationDate: FloatingTextField!
    @IBOutlet weak var bottonButtonConstraint: NSLayoutConstraint!
    
    private var isEditingCard: Bool = false
    private var viewModel: PaymentViewModel?
    private var activeTextField = UITextField()
    private var interactor: RegisterCardInteractor?
    
    init(interactor: RegisterCardInteractor, viewModel: PaymentViewModel, isEditing: Bool) {
        super.init(nibName: "RegisterNewCardViewController", bundle: Bundle.main)
        self.viewModel = viewModel
        self.interactor = interactor
        self.isEditingCard = isEditing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        saveButton.layer.cornerRadius = 25
        
        if isEditingCard {
            interactor?.loadCard()
        }
    }
    
    private func setup() {
        cardNumber.delegate = self
        securityCode.delegate = self
        cardOwnerName.delegate = self
        expirationDate.delegate = self
        
        cardNumber.validation = { $0.count == 19 }
        cardOwnerName.validation = { $0.count > 3 }
        securityCode.validation = { $0.count == 3 }
        expirationDate.validation = { $0.count == 5 }

        addNotificantionObreservers()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    private func addNotificantionObreservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(textField:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                if self.activeTextField.frame.origin.y + 150 > self.view.frame.height - keyboardSize.height {
                    self.view.frame.origin.y -= (self.activeTextField.frame.origin.y + 150) - (self.view.frame.height - keyboardSize.height)
                
                    self.bottonButtonConstraint.constant = (self.activeTextField.frame.origin.y + 160) - (keyboardSize.height)
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            self.bottonButtonConstraint.constant = 24
        }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        AppRouter.shared.popViewController()
    }
    
    @IBAction func saveCardPressed(_ sender: Any) {
        let card = Card(owner: cardOwnerName.text ?? "",
                        cardNumber: cardNumber.text ?? "",
                        securityCode: securityCode.text ?? "",
                        expirationDate: expirationDate.text ?? "")
        
        viewModel?.card = card
        interactor?.saveCard(card)
    }
}

extension RegisterNewCardViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        
        switch textField.tag {
        
        case 0:
            textField.text = modifyCreditCardString(creditCardString: textField.text ?? "")
            return count <= 19
        case 1:
            return count <= 50
        case 2:
            textField.text = modifyExpirationDateString(date: textField.text ?? "")
            return count <= 5
        case 3:
            return count <= 3
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @objc func textDidChange(textField:UITextField) {
        self.saveButton.isHidden = validateForm()
    }
    
    private func modifyCreditCardString(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        
        var modifiedCreditCardString = ""
        
        if !trimmedString.isEmpty {
            for (i, char) in trimmedString.enumerated() {
                modifiedCreditCardString.append(char)
                
                if ((i+1) % 4 == 0 && i+1 != trimmedString.count) {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        return modifiedCreditCardString
    }
    
    private func modifyExpirationDateString(date: String) -> String {
        var expirationDate = date
        
        if expirationDate.count == 2 {
            expirationDate.append("/")
        }
        
        return expirationDate
    }
    
    private func validateForm() -> Bool {
        return !(cardNumber.isVaridate() &&
               cardOwnerName.isVaridate() &&
               securityCode.isVaridate() &&
               expirationDate.isVaridate())
    }
}

extension RegisterNewCardViewController: RegisterCardViewProtocol {
    func displayCardSaved(success: Bool) {
        if success {
            guard let paymentModel = viewModel else { return }
            AppRouter.shared.routeToPayment(paymentModel)
        }
    }
    
    func displayCardRetrieved(card: Card) {
        cardOwnerName.text = card.owner
        cardNumber.text = card.cardNumber
        securityCode.text = card.securityCode
        expirationDate.text = card.expirationDate
        
        self.saveButton.isHidden = validateForm()
    }
}
