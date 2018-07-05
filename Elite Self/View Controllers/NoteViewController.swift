//
//  TaskViewController.swift
//  Elite Self
//
//  Created by Администратор on 11/02/2018.
//  Copyright © 2018 alejandra. All rights reserved.
//

import UIKit
import UserNotifications

class NoteViewController: UIViewController, UITextViewDelegate, UNUserNotificationCenterDelegate { 
    // MARK: - Outlets prorerties
    @IBOutlet weak var todayPlansTextView: UITextView!
    @IBOutlet weak var thankTextView: UITextView!
    @IBOutlet var thnxView: UIView!
    @IBOutlet weak var noteDate: UITextField!
    // Properties to save text with UserDefault
    let saveTextKey = "textViewContent"
    let defaults = UserDefaults.standard
    
    let tintButtonColor = UIColor(hue: 0.62, saturation: 0.5, brightness: 0.206, alpha: 1.0)
    // MARK: - viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todayPlansTextView.delegate = self
        shapeThnxView()
        notesDate()
        UserNotificationManager.shared.delegate()
        UserNotificationManager.shared.notifyUser()
        doneKeyboardButton()
        registerNotifToShowTextAboveKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTextFromUserDefaults()
    }
    func notesDate() {
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.locale = Locale(identifier: "en_EN")
        dateFormatter.setLocalizedDateFormatFromTemplate("d MMMM yyyy")
        noteDate.text = "Manifest your day, \(dateFormatter.string(from: date))"
    }
    func doneKeyboardButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        doneButton.tintColor = tintButtonColor
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        thankTextView.inputAccessoryView = toolBar
        todayPlansTextView.inputAccessoryView = toolBar
    }
    @objc func doneButtonClicked() {
        view.endEditing(true)
    }
    func saveText() {
        defaults.set(todayPlansTextView.text, forKey: saveTextKey)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        saveText()
    }
    func textViewDidChange(_ textView: UITextView) {
        saveText()
    }
    func loadTextFromUserDefaults() {
        if let textViewContents = defaults.string(forKey: saveTextKey) {
            todayPlansTextView.text = textViewContents
        } else {
            todayPlansTextView.becomeFirstResponder()
        }
    }
    
    // textView editing mode, make display user text above keyboard
    func registerNotifToShowTextAboveKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(textAboveKeyboard), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textAboveKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func textAboveKeyboard(notification: Notification) {
        let userInfo = notification.userInfo
        let getKeyboardRect = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboardRect, to: view.window)
        if notification.name == Notification.Name.UIKeyboardWillHide {
            todayPlansTextView.contentInset = UIEdgeInsets.zero
        } else {
            todayPlansTextView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0)
            todayPlansTextView.scrollIndicatorInsets = todayPlansTextView.contentInset
        }
        todayPlansTextView.scrollRangeToVisible(todayPlansTextView.selectedRange)
    }
    
    @IBAction func clearTextView(_ sender: UIBarButtonItem) {
        defaults.removeObject(forKey: saveTextKey)
        todayPlansTextView.text = " "
    }
    func shapeThnxView() {
        thnxView.layer.cornerRadius = 20.0
        thnxView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner,
                                        .layerMinXMaxYCorner, .layerMinXMinYCorner]
        thnxView.clipsToBounds = true
        thnxView.center.x = view.center.x
        thnxView.center.y  = view.center.y - thnxView.bounds.height * 2
        view.addSubview(thnxView)
    }
    func animateAppearanceThankView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.thnxView.transform = CGAffineTransform(translationX: 0.0, y: self.view.bounds.height / 1.5 + self.thnxView.bounds.size.height / 1.5)
        })
    }
    func hideThnxView() {
        UIView.animate(withDuration: 0.4, animations: {
            self.thnxView.transform = CGAffineTransform(translationX: 0.0, y: -800)
        })
    }
    
    @IBAction func showThnxView(_ sender: UIBarButtonItem) {
        animateAppearanceThankView()
        thankTextView.text = ""
    }
    
    @IBAction func sendThank(_ sender: Any) {
        hideThnxView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "toGoalsViewController" || segue.identifier == "toVisualBoard" {
            hideThnxView()
        }
    }
    override var prefersStatusBarHidden: Bool { return false }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent}
}

