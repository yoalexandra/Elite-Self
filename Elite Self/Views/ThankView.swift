//
//  ThankView.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 30/08/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class ThankView: UIView {
    
    @IBOutlet weak var thankText: UITextView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    // MARK: - Gradient
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    @IBInspectable var horizontalGradient: Bool = false {
        didSet {
            updateView()
        }
    }
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ firstColor.cgColor, secondColor.cgColor ]
        
        if (horizontalGradient) {
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
    }
    func addDoneKeyboardButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        let trashButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(self.clearTextView))
        trashButton.tintColor = customTintColor
        doneButton.tintColor = customTintColor
        toolBar.setItems([trashButton, flexibleSpace, doneButton], animated: false)
        thankText.inputAccessoryView = toolBar
    }
    @objc func doneButtonClicked() {
        thankText.resignFirstResponder()
    }
    @objc func clearTextView() {
        thankText.text = " "
    }
}



