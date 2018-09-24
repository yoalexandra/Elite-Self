//
//  NoteViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 11/02/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import UserNotifications

class NoteViewController: UIViewController, UITextViewDelegate, UNUserNotificationCenterDelegate {
    // MARK: - Outlets prorerties
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var noteDate: AlignUILabelText!
    @IBOutlet weak var thankView: ThankView!
    @IBOutlet weak var thankTextView: UITextView!
    @IBOutlet weak var showThankViewButton: UIBarButtonItem!
    // Properties to save text with UserDefault
    let saveTextKey = "textViewContent"
    let defaults = UserDefaults.standard
    // ====================================
    // MARK: - Localizable strings property
    // ====================================
    let noteDateTitle = NSLocalizedString("Manifest your day", comment: "")
    
    let tintButtonColor = UIColor.init(hexValue: "#204764", alpha: 1.0)
    // MARK: - viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesTextView.delegate = self
        displayTodayDate()
        NotifyUserManager.shared.delegate()
        NotifyUserManager.shared.notifyUser()
        doneKeyboardButton()
        registerNotifToShowTextAboveKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTextFromUserDefaults()
    }
    func displayTodayDate() {
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.locale = Locale(identifier: "en_EN")
        dateFormatter.setLocalizedDateFormatFromTemplate("d MM yyyy")
        noteDate.text = "\(noteDateTitle), \(dateFormatter.string(from: date))"
    }
    func doneKeyboardButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        doneButton.tintColor = tintButtonColor
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        notesTextView.inputAccessoryView = toolBar
    }
    @objc func doneButtonClicked() {
        view.endEditing(true)
    }
    func saveText() {
        defaults.set(notesTextView.text, forKey: saveTextKey)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        saveText()
    }
    func textViewDidChange(_ textView: UITextView) {
        saveText()
    }
    func loadTextFromUserDefaults() {
        if let textViewContents = defaults.string(forKey: saveTextKey) {
            notesTextView.text = textViewContents
        } else {
            notesTextView.becomeFirstResponder()
        }
    }
    // textView editing mode, make display user text above keyboard
    func registerNotifToShowTextAboveKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(textAboveKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textAboveKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func textAboveKeyboard(notification: Notification) {
        let userInfo = notification.userInfo
        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboardRect, to: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            notesTextView.contentInset = UIEdgeInsets.zero
        } else {
            notesTextView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
            notesTextView.scrollIndicatorInsets = notesTextView.contentInset
        }
        notesTextView.scrollRangeToVisible(notesTextView.selectedRange)
    }
    
    @IBAction func clearTextView(_ sender: UIBarButtonItem) {
        defaults.removeObject(forKey: saveTextKey)
        notesTextView.text = " "
    }
    // Awake ThankView from nib
    func awakeThankViewFromNib() {
        let nib = UINib.init(nibName: "ThankView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        if let thankView = thankView {
            thankView.center = view.center
            view.addSubviewWithFadeAnimation(thankView, duration: 1.2, options: .curveEaseIn)
        }
    }
    @IBAction func showThnxView(_ sender: UIBarButtonItem) {
        awakeThankViewFromNib()
        showThankViewButton.isEnabled = false
        thankTextView.text = ""
    }
    @IBAction func sendThank(_ sender: UIButton) {
        thankView?.removeSubviewWithTransform(duration: 0.4)
        showThankViewButton.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toGoalsViewController" || segue.identifier == "toVisualBoard" {
            thankView?.removeSubviewWhenPerformSegue(duration: 0.1)
            showThankViewButton.isEnabled = true
        }
    }
    override var prefersStatusBarHidden: Bool { return false }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent}
}
