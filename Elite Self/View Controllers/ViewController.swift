//
//  ViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 11/02/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, StoryboardedVCs, UITextViewDelegate {
    
    weak var coordinator: MainCoordinator?
    // MARK: - Outlets prorerties
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var thankView: ThankView!
    @IBOutlet weak var thankTextView: UITextView!
    @IBOutlet weak var showThankViewButton: UIBarButtonItem!
    // Properties to save text with UserDefaults
    let saveTextKey = "textViewContent"
    let defaults = UserDefaults.standard
    
    var dateLabel = UILabel()
    var backBtn = UIButton()
    var nextBtn = UIButton()
    // MARK: - Localizable strings properties
    let largeTitleText = NSLocalizedString("Manifest your day", comment: "")
    let buttonActionBackText = NSLocalizedString("Back", comment: "")
    let buttonActionNextText = NSLocalizedString("Next", comment: "")
    // MARK: - viewDidLoad method in case you lost lol
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesTextView.delegate = self
        setupNavigationBar()
        displayTodayDate()
        addActionsNavigarionBarButtons()
        NotifyUserManager.shared.delegate()
        NotifyUserManager.shared.notifyUser()
        doneKeyboardButton()
        registerNotifToShowTextAboveKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTextFromUserDefaults()
    }

    // MARK: - Navigation bar, design navigation bar
    func setupNavigationBar() {
        navigationItem.title = largeTitleText
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem?.tintColor = customTintColor
        navigationItem.rightBarButtonItem?.tintColor = customTintColor
        let btnFrame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        backBtn.frame = btnFrame
        nextBtn.frame = btnFrame
        backBtn.setTitle(buttonActionBackText, for: .normal)
        backBtn.setTitleColor(customTintColor, for: .normal)
        nextBtn.setTitle(buttonActionNextText, for: .normal)
        nextBtn.setTitleColor(customTintColor, for: .normal)
        dateLabel.textColor = customTintColor
        dateLabel.font = UIFont(name: "Helvetica", size: 20)
        
        let stackView = UIStackView(arrangedSubviews: [backBtn, dateLabel, nextBtn])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        navigationItem.titleView = stackView
        /* let searchBar = UISearchBar()
         searchBar.sizeToFit()
         searchBar.placeholder = "Find date"
         self.navigationController?.navigationItem.titleView = searchBar*/
    }
    // Navigation Bar buttons actions
    func addActionsNavigarionBarButtons() {
        backBtn.addTarget(self, action: #selector(previousDate), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(nextDate), for: .touchUpInside)
    }
    // Get previous day
    @objc func previousDate(sender: UIButton!) {
        date = date.getPreviousDay()!
        formatDate(date, textLabel: dateLabel)
    }
    // Get next day
    @objc func nextDate(sender: UIButton!) {
        date = date.getNextDay()!
        formatDate(date, textLabel: dateLabel)
    }
    func displayTodayDate() { formatDate(date, textLabel: dateLabel) }
    
    func doneKeyboardButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        doneButton.tintColor = customTintColor
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
            view.addSubviewWithFadeAnimation(thankView, duration: 1.2, options: .curveEaseIn)
        }
    }
    
    // @IBActions
    @IBAction func clearTextView(_ sender: UIBarButtonItem) {
        defaults.removeObject(forKey: saveTextKey)
        notesTextView.text = " "
    }
    @IBAction func presentVisualBoardVC(_ sender: UIBarButtonItem) {
        coordinator?.visualBoardSubscription()
    }
    @IBAction func presentGoalsVC(_ sender: UIBarButtonItem) {
        coordinator?.goasVClSubscription()
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
    override var prefersStatusBarHidden: Bool { return false }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent}
}
