//
//  PrivacyViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 28/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import WebKit

class PrivacyViewController: UIViewController, StoryboardedVCs  {
    //MARK: - Properties
    weak var coordinator: MainCoordinator?
    //MARK: - IBOutlet properties
    @IBOutlet weak var privacyWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigatonBarButtons()
        addWebViewContent()
    }
    // MARK: - Navigation Bar
    func addNavigatonBarButtons() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPPVC))
        navigationItem.rightBarButtonItem?.tintColor = customTintColor
    }
    @objc func dismissPPVC() {
        //TODO: Custom transition
        coordinator?.settingsVCSubscription()
    }
    // MARK: - WebView
    func addWebViewContent() {
        do {
            guard let filePath = Bundle.main.path(forResource: "privacy_policy", ofType: "html") else {
                fatalError("File not found")
            }
            let content = try String(contentsOfFile: filePath, encoding: .utf8)
            let url = URL(fileURLWithPath: filePath)
            privacyWebView.loadHTMLString(content as String, baseURL: url)
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}

