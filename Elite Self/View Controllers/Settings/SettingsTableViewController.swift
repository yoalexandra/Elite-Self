//
//  SettingsTableViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, StoryboardedVCs {
    
    weak var coordinator: MainCoordinator?
    
    let sectionHeaderTitles = ["Manage notifications", "Privacy Policy"]
    let sectionFooterTitles = ["Schedule notifications, choose time to get your positive words. You can turn it On/Off in System Settings", "Privacy policy and support"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigatonBarButtons()
        registerTableViewCells()
    }
    // MARK: - Navigation Bar
    func addNavigatonBarButtons() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: backButtonTitle, style: .done, target: self, action: #selector(dismissSVC))
        navigationItem.rightBarButtonItem?.tintColor = customTintColor
    }
    
    @objc func dismissSVC() {
        coordinator?.presenter.popToRootViewController(animated: true)
    }
    func registerTableViewCells() {
        self.tableView?.register(ManageNotificationCell.nib, forCellReuseIdentifier: ManageNotificationCell.identifier)
        self.tableView?.register(PrivacyPolicyCell.nib, forCellReuseIdentifier: PrivacyPolicyCell.identifier)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            break
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell0 = tableView.dequeueReusableCell(withIdentifier: ManageNotificationCell.identifier, for: indexPath) as! ManageNotificationCell
            return cell0
        case 1:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: PrivacyPolicyCell.identifier, for: indexPath) as! PrivacyPolicyCell
            cell1.privacyPolicyLabel.text = "Privacy Policy"
            return cell1
        default: break
        }
        return tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("Set up later")
        case 1:
            coordinator?.ppVCSubscription()
        default: break
        }
    }
    // Set header & footer titles for cell sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderTitles[section]
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionFooterTitles[section]
    }
    
}
