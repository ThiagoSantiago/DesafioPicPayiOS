//
//  RegisterNewCardViewController.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class RegisterNewCardViewController: UIViewController {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cardNumber: FloatingTextField!
    @IBOutlet weak var securityCode: FloatingTextField!
    @IBOutlet weak var cardOwnerName: FloatingTextField!
    @IBOutlet weak var expirationDate: FloatingTextField!
    

    init() {
        super.init(nibName: "RegisterNewCardViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        saveButton.layer.cornerRadius = 25
    }
    
    private func setup() {
        cardNumber.delegate = self
        securityCode.delegate = self
        cardOwnerName.delegate = self
        expirationDate.delegate = self
        
        cardNumber.validation = { $0.count == 16 }
        cardOwnerName.validation = { $0.count > 3 }
        securityCode.validation = { $0.count == 3 }
        expirationDate.validation = { $0.count == 5 }
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        AppRouter.shared.popViewController()
    }
    
    @IBAction func saveCardPressed(_ sender: Any) {
        AppRouter.shared.routeToHome()
    }
}

extension RegisterNewCardViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        
        switch textField.tag {
        
        case 0:
            return count <= 16
        case 1:
            return count <= 50
        case 2:
            return count <= 5
        case 3:
            return count <= 3
        default:
            return true
        }
    }
}
