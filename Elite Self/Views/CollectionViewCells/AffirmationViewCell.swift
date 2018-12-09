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
    
    // Properties to save text with UserDefaults
    let saveAffimationTextKey = "userAffirmationText"
    let defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
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
        affirmationViewText.inputAccessoryView = toolBar
    }
    @objc func doneButtonClicked() {
        affirmationViewText.resignFirstResponder()
    }
    @objc func clearTextView() {
         defaults.removeObject(forKey: saveAffimationTextKey)
        affirmationViewText.text = ""
    }

    func saveText() {
        defaults.set(affirmationViewText.text, forKey: saveAffimationTextKey )
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        saveText()
    }
    func textViewDidChange(_ textView: UITextView) {
        saveText()
    }
    func loadTextFromUserDefaults() {
        if let textViewContents = defaults.string(forKey: saveAffimationTextKey) {
           affirmationViewText.text = textViewContents
        } else {
            affirmationViewText.becomeFirstResponder()
        }
    }
}

