//
//  FloatingTextField.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class FloatingTextField: UITextField {
    private var floatingPlaceholderLabel: UILabel = UILabel()
    
    open override var font: UIFont? {
        didSet {
            floatingPlaceholderLabel.font = font
        }
    }
    
    var floatingPlaceholderMinFontSize: CGFloat = 14
    var floatintPlaceholderDuration: Double = 0.2
    var floatingPlaceholderColor: UIColor = .lightGray
    var validationFalseLineEditingColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    var validationTrueLineEditingColor: UIColor = UIColor(red: 0.07, green: 0.78, blue: 0.44, alpha: 1)
    var validationFalseLineColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    var validationTrueLineColor: UIColor = UIColor(red: 0.07, green: 0.78, blue: 0.44, alpha: 1)
    var validation: ((String) -> Bool)?
    private var leftPadding: CGFloat = 16
    private var floatingPlaceholderBottomMargin: CGFloat = 9
    private var floatingPlaceholderBottomConstraint: NSLayoutConstraint!
    private var floatingPlaceholderLeadingConstraint: NSLayoutConstraint!
    private var underLineViewWidth: NSLayoutConstraint?
    private var underLineView: UIView?
    private var underLineColor: UIColor?
    private var oldUnderLineView: UIView?
    private var isFloat = false
    private var shouldFloat = false
    
    override open var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize
        return CGSize(width: intrinsicContentSize.width,
                      height: intrinsicContentSize.height + floatingPlaceholderBottomMargin + floatingPlaceholderLabel.bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
        
        if isFirstResponder && text == "" && !isFloat {
            placeholder(toFloat: true)
        }
        
        else if !isFirstResponder && text == "" && isFloat {
            placeholder(toFloat: false)
        }
        
        if text != "" && !isFloat {
            isFloat = true
            DispatchQueue.main.async {
                self.placeholder(toFloat: true)
                self.animateBottomLineColor()
            }
            
        }
        
        changeBottomLineColor()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return CGRect(x: rect.origin.x, y: rect.origin.y + floatingPlaceholderBottomMargin, width: rect.size.width, height: rect.size.height).integral
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return CGRect(x: rect.origin.x, y: rect.origin.y + floatingPlaceholderBottomMargin, width: rect.size.width, height: rect.size.height).integral
    }
    
    private func setup() {
        borderStyle = .none
        setupFloatingPlaceholder()
        
        DispatchQueue.main.async {
            self.setupUnderLineView()
        }
    }
    
    private func setupFloatingPlaceholder() {
        floatingPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        floatingPlaceholderLabel.text = placeholder
        floatingPlaceholderLabel.textColor = floatingPlaceholderColor
        floatingPlaceholderLabel.font = font
        placeholder = nil
        addSubview(floatingPlaceholderLabel)
        floatingPlaceholderLeadingConstraint = floatingPlaceholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        floatingPlaceholderLeadingConstraint.isActive = true
        floatingPlaceholderBottomConstraint = floatingPlaceholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -floatingPlaceholderBottomMargin)
        floatingPlaceholderBottomConstraint.isActive = true
    }
    
    private func setupUnderLineView() {
        oldUnderLineView = UIView()
        oldUnderLineView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(oldUnderLineView!)
        oldUnderLineView?.heightAnchor.constraint(equalToConstant: 2).isActive = true
        oldUnderLineView?.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        oldUnderLineView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        oldUnderLineView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        underLineView = UIView()
        underLineView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(underLineView!)
        underLineView?.heightAnchor.constraint(equalToConstant: 2).isActive = true
        underLineViewWidth = underLineView?.widthAnchor.constraint(equalToConstant: 0)
        underLineViewWidth?.isActive = true
        underLineView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        underLineView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func placeholder(toFloat: Bool) {
        isFloat = toFloat
        floatingPlaceholderBottomConstraint.constant = toFloat ? -bounds.height + floatingPlaceholderLabel.frame.height : -floatingPlaceholderBottomMargin
        if isFloat {
            floatingPlaceholderLabel.textColor = UIColor(red: 0.07, green: 0.78, blue: 0.44, alpha: 1)
        } else {
            floatingPlaceholderLabel.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        }
        
        shouldFloat = true
    }
    
    private func changeBottomLineColor() {
        if underLineColor == nil {
            underLineColor = validationFalseLineColor
            animateBottomLineColor()
        } else if isFirstResponder && isVaridate() && underLineColor != validationTrueLineEditingColor {
            underLineColor = validationTrueLineEditingColor
            animateBottomLineColor()
        } else if isFirstResponder && !isVaridate() && underLineColor != validationFalseLineEditingColor {
            underLineColor = validationFalseLineEditingColor
            animateBottomLineColor()
        } else if !isFirstResponder && isVaridate() && underLineColor != validationTrueLineColor {
            underLineColor = validationTrueLineColor
            animateBottomLineColor()
        } else if !isFirstResponder && !isVaridate() && underLineColor != validationFalseLineColor {
            underLineColor = validationFalseLineColor
            animateBottomLineColor()
        }
    }
    
    func isVaridate() -> Bool {
        guard let text = text else { return false }
        guard let validation = validation else { return false }
        return validation(text)
    }
    
    private func animateBottomLineColor() {
        underLineView?.backgroundColor = underLineColor
        underLineViewWidth?.constant = bounds.width
        
        let ratio = isFloat ? floatingPlaceholderMinFontSize / font!.pointSize : font!.pointSize / floatingPlaceholderMinFontSize
        UIView.animate(withDuration: floatintPlaceholderDuration, delay: 0, options: .curveLinear, animations: {
            self.layoutIfNeeded()
            if self.shouldFloat {
                self.floatingPlaceholderLabel.transform = self.floatingPlaceholderLabel.transform.scaledBy(x: ratio, y: ratio)
                self.shouldFloat = false
            }
        }, completion: { _ in
            self.underLineViewWidth?.constant = 0
            self.oldUnderLineView?.backgroundColor = self.underLineColor
        })
    }
}
