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
    let sectionFooterTitles = ["Schedule notifications, add more positive quotes", " Read Privacy policy"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Navigation
    //
    //   coordinator?.presenter.popToRootViewController(animated: true)
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            break
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderTitles[section]
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionFooterTitles[section]
    }
    
    
}
