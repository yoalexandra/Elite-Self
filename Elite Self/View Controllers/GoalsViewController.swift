//
//  GoalsViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 02/03/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import SpriteKit

class GoalsViewController: UIViewController, StoryboardedVCs, UITextViewDelegate {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var goalsTextView: UITextView!
    // Property to save text with UserDefaults
    let textViewContents = "textView"
    let defaults = UserDefaults.standard
    // MARK: - Localizable strings properties
    let largeTitleText = NSLocalizedString("Dream bigger", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalsTextView.delegate = self
        addNavigatonBarButtons()
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
    func setupNavigationBar() {
        navigationItem.title = largeTitleText
        navigationItem.largeTitleDisplayMode = .always
    }
    func addNavigatonBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissGVC))
        navigationItem.rightBarButtonItem?.tintColor = customTintColor
        navigationItem.setHidesBackButton(true, animated: false)
    }
    @objc func dismissGVC() {
        // TODO: Custom transition
        _ = navigationController?.popToRootViewController(animated: true)
        //coordinator?.start() this or that 👆🏻 ???
    }
 
    func doneKeyboardButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let trashButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(self.clearTextView))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        trashButton.tintColor = customTintColor
        doneButton.tintColor = customTintColor
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
    // TextView editing mode, make display user text input above keyboard
    func registerNotifToShowTextAboveKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(editingTextAboveKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editingTextAboveKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func editingTextAboveKeyboard(notification: Notification) {
        let userInfo = notification.userInfo
        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboardRect, to: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            goalsTextView.contentInset = UIEdgeInsets.zero
        } else {
            goalsTextView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
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
