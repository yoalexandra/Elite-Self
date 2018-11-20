//
//  AffirmationViewCell.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 28/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class AffirmationViewCell: UICollectionViewCell,  UITextViewDelegate  {
    
    @IBOutlet weak var affirmationViewText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10.0
        contentView.clipsToBounds = true
    }
    //TODO: add inputAccessoryView to text view
    func addDoneKeyboardButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        let trashButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(self.clearTextView))
        trashButton.tintColor = customTintColor
        doneButton.tintColor = customTintColor
        toolBar.setItems([trashButton, flexibleSpace, doneButton], animated: false)
        affirmationViewText.inputAccessoryView = toolBar
    }
    @objc func doneButtonClicked() {
        affirmationViewText.resignFirstResponder()
    }
    @objc func clearTextView() {
        affirmationViewText.text = " "
    }
}

