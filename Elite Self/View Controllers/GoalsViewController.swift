//
//  RandomQuotes.swift
//  Elite Self
//
//  Created by Администратор on 02/03/2018.
//  Copyright © 2018 alejandra. All rights reserved.
//

import UIKit
import SpriteKit

class GoalsViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var goalsTextView: UITextView!
    // Property to save text with UserDefault
    let textViewContents = "textView"
    let defaults = UserDefaults.standard
    let tintButtonColor = UIColor(hue: 0.62, saturation: 0.5, brightness: 0.206, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalsTextView.delegate = self
        navigatonBarButtons()
        setupNavigationBar()
        doneKeyboardButton()
        registerNotifToShowTextAboveKeyboard()
        loadSKScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadTextFromUserDefaults()
    }
    
    // MARK: - Navigation Bar
    func navigatonBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissGVC))
        navigationItem.rightBarButtonItem?.tintColor = tintButtonColor
    }
    @objc func dismissGVC() {
        dismiss(animated: true, completion: nil)
    }
    func setupNavigationBar() {
        navigationItem.title = "Dreams are free"
        navigationItem.largeTitleDisplayMode = .always
    }
    func doneKeyboardButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let trashButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(self.clearTextView))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        trashButton.tintColor = tintButtonColor
        doneButton.tintColor = tintButtonColor
        toolBar.setItems([trashButton, flexibleSpace, doneButton], animated: false)
        goalsTextView.inputAccessoryView = toolBar
    }
    @objc func clearTextView() {
        defaults.removeObject(forKey: textViewContents)
        goalsTextView.text = " "
    }
    @objc func doneButtonClicked() {
        view.endEditing(true)
    }
    
    func saveText() {
        defaults.set(goalsTextView.text, forKey: textViewContents)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        saveText()
    }
    
    func loadTextFromUserDefaults() {
        if let textViewContents = defaults.string(forKey: textViewContents) {
            goalsTextView.text = textViewContents
        } else {
            goalsTextView.becomeFirstResponder()
        }
    }
    // textView editing mode, make display user input text above keyboard
    func registerNotifToShowTextAboveKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(editingTextAboveKeyboard), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editingTextAboveKeyboard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func editingTextAboveKeyboard(notification: Notification) {
        let userInfo = notification.userInfo
        let getKeyboardRect = (userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboardRect, to: view.window)
        if notification.name == Notification.Name.UIKeyboardWillHide {
            goalsTextView.contentInset = UIEdgeInsets.zero
        } else {
            goalsTextView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardFrame.height, 0.0)
            goalsTextView.scrollIndicatorInsets = goalsTextView.contentInset
        }
        goalsTextView.scrollRangeToVisible(goalsTextView.selectedRange)
    }
    func loadSKScene() {
        let emitterScene = StarsScene()
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        emitterScene.size = view.bounds.size
        skView.presentScene(emitterScene)
    }
    override var prefersStatusBarHidden: Bool { return false }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
} // End class
