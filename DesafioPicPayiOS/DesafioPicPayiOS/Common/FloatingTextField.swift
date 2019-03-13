//
//  FloatingTextField.swift
//  DesafioPicPayiOS
//
//  Created by Thiago Santiago on 3/12/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class FloatingTextField: UITextField {

    /// Placeholder rising up when editing
    private var floatingPlaceholderLabel: UILabel = UILabel()
    
    /// enable change to font
    open override var font: UIFont? {
        didSet {
            floatingPlaceholderLabel.font = font
        }
    }
    
    /// Placeholder min font size
    open var floatingPlaceholderMinFontSize: CGFloat = 14
    
    /// Placeholder animation duration
    open var floatintPlaceholderDuration: Double = 0.2
    
    /// Placeholder color
    open var floatingPlaceholderColor: UIColor = .lightGray
    
    /// Under line color when editing and validation is not ok
    open var validationFalseLineEditingColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    
    /// Under line color when editing and validation is not ok
    open var validationTrueLineEditingColor: UIColor = UIColor(red: 0.07, green: 0.78, blue: 0.44, alpha: 1)
    
    /// Under line color when not editing and validation is not ok
    open var validationFalseLineColor: UIColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    
    /// Under line color when not editing and validation is ok
    open var validationTrueLineColor: UIColor = UIColor(red: 0.07, green: 0.78, blue: 0.44, alpha: 1)
    
    /// Validation function
    open var validation: ((String) -> Bool)?
    
    /// Padding to the left of text
    private var leftPadding: CGFloat = 16
    
    /// Margin under placeholder when on top
    private var floatingPlaceholderBottomMargin: CGFloat = 9
    
    /// Placeholder Bottom Constraint
    private var floatingPlaceholderBottomConstraint: NSLayoutConstraint!
    
    /// Placeholder Leading Constraint
    private var floatingPlaceholderLeadingConstraint: NSLayoutConstraint!
    
    /// Under line width constraint
    private var underLineViewWidth: NSLayoutConstraint?
    
    /// Under line View
    private var underLineView: UIView?
    
    /// Now under line color
    private var underLineColor: UIColor?
    
    /// Old under line color
    private var oldUnderLineView: UIView?
    
    /// Whether placeholder is above
    private var isFloat = false
    
    /// Whether placehlder should be avove
    private var shouldFloat = false
    
    /// set up size of self
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
        
        // When editing is started in case character input is not made
        if isFirstResponder && text == "" && !isFloat {
            placeholder(toFloat: true)
        }
            // When editing is ended when character input is not made
        else if !isFirstResponder && text == "" && isFloat {
            placeholder(toFloat: false)
        }
        
        // When an initial value is given to textfield
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
    
    /// Initial set
    private func setup() {
        borderStyle = .none
        setupFloatingPlaceholder()
        
        DispatchQueue.main.async {
            self.setupUnderLineView()
        }
    }
    
    /// Set up placeholder label
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
    
    /// Set up under view
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
    
    /// Move placeholder label
    private func placeholder(toFloat: Bool) {
        isFloat = toFloat
        floatingPlaceholderBottomConstraint.constant = toFloat ? -bounds.height + floatingPlaceholderLabel.frame.height : -floatingPlaceholderBottomMargin

        shouldFloat = true
    }
    
    /// change bottom line color
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
    
    /// Whether if validation ok
    private func isVaridate() -> Bool {
        guard let text = text else { return false }
        guard let validation = validation else { return true }
        return validation(text)
    }
    
    /// Set bottom line with animation
    private func animateBottomLineColor() {
        underLineView?.backgroundColor = underLineColor
        underLineViewWidth?.constant = bounds.width
        
        // placeholder size ratio
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
