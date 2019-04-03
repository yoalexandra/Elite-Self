//
//  ViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 11/02/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import SpriteKit
import UserNotifications

class ViewController: UIViewController, StoryboardedVCs, UITextViewDelegate {
    
    weak var coordinator: MainCoordinator?
    // MARK: - Outlets prorerties
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var thankView: ThankView!
    @IBOutlet weak var showThankViewButton: UIBarButtonItem!
    
    @IBOutlet weak var toolbar: UIToolbar!
    // Properties to save text with UserDefaults
    let saveTextKey = "textViewContent"
    let defaults = UserDefaults.standard
  
    //var dateLabel = UILabel()
    // MARK: - Localizable strings properties
    let largeTitleText = NSLocalizedString("Manifest your day", comment: "")
	
    // MARK: - viewDidLoad method in case you lost lol I know you will be
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notesTextView.delegate = self
        setupNavigationBar()
        //displayTodayDate() ok now is only matter
		toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
		toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        NotifyUserManager.shared.delegate()
		NotifyUserManager.shared.notifyUser()
		loadSKScene()
        addKeyboardButtons()
        registerNotifToShowTextAboveKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTextFromUserDefaults()
    }
    // MARK: - Navigation bar
    func setupNavigationBar() {
        navigationItem.title = largeTitleText
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = customTintColor
        navigationItem.setHidesBackButton(true, animated: false)
        
//        dateLabel.frame = CGRect(x: 0.0, y: 0.0, width: 250.0, height: 30.0)
//        dateLabel.textColor = customTintColor
//        dateLabel.textAlignment = .center
//        dateLabel.font = customFont
        //navigationItem.titleView = dateLabel
    }
  
    //func displayTodayDate() { formatDate(date, textLabel: dateLabel) }
    
    func addKeyboardButtons() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let trashButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(self.clearTextView))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        trashButton.tintColor = customTintColor
        doneButton.tintColor = customTintColor
        toolBar.setItems([trashButton, flexibleSpace, doneButton], animated: false)
        notesTextView.inputAccessoryView = toolBar
    }
    @objc func doneButtonClicked() {
        view.endEditing(true)
    }
    @objc func clearTextView() {
        defaults.removeObject(forKey: saveTextKey)
        notesTextView.text = ""
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
    // TextView editing mode, make display user text above keyboard
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
    // Awake ThankView from nib
    func awakeThankViewFromNib() {
        let nib = UINib.init(nibName: "ThankView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        if let thankView = thankView {
            thankView.center = view.center
            view.addSubviewWithFadeAnimation(thankView, duration: 1.0, options: .curveEaseIn)
            thankView.addDoneKeyboardButton()
        }
    }
	
	func loadSKScene() {
		let emitterScene = StarsScene()
		let skView = self.view as! SKView
		skView.ignoresSiblingOrder = true
		emitterScene.size = view.bounds.size
		skView.presentScene(emitterScene)
	}
    
    // MARK: - @IBActions
    // ViewControllers navigation
    @IBAction func presentVisualBoardVC(_ sender: UIBarButtonItem) {
        coordinator?.visualBoardSubscription()
        thankView?.removeSubview()
        showThankViewButton.isEnabled = true
    }
	
    @IBAction func presentCardsVC(_ sender: UIBarButtonItem) {
        coordinator?.cardsVCSubscription()
        thankView?.removeSubview()
        showThankViewButton.isEnabled = true
    }
    
    // ThankView events
    @IBAction func showThnxView(_ sender: UIBarButtonItem) {
        awakeThankViewFromNib()
        showThankViewButton.isEnabled = false
    }
    @IBAction func sendThank(_ sender: UIButton) {
        thankView?.removeSubviewWithTransform(duration: 0.4)
        showThankViewButton.isEnabled = true
    }
	
    override var prefersStatusBarHidden: Bool { return false }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent}
}

