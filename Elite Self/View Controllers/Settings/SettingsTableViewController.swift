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
	var delegate: TimePickerDelegate?
	
    var expandedRows = Set<Int>()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
		
        addNavigatonBarButtons()
		
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
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "title")
            cell?.textLabel?.textColor = customTintColor
            cell?.textLabel?.text = "Privacy Policy"
            return cell!
        }
        // Expanable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectTime" , for: indexPath) as! SelectTimeViewCell
		
			delegate?.newDate = cell.timePicker.date
            cell.selectTimeCellLabel.textColor = customTintColor
            cell.isExpanded = self.expandedRows.contains(indexPath.row)
		
            return cell
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        }
        return 200.0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            coordinator?.ppVCSubscription()
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? SelectTimeViewCell
            else { return }
        
        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        cell.isExpanded = !cell.isExpanded
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let cell = tableView.cellForRow(at: indexPath) as? SelectTimeViewCell
                else { return }
			
            self.expandedRows.remove(indexPath.row)
            cell.isExpanded = false
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    // Set header & footer titles for cell sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:  return  "Privacy Policy"
        case 1:  return "Manage notifications"
        default: return ""
        }
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:  return "Privacy policy and support"
        case 1:  return "Schedule notifications, choose time to get your positive words. Elite Self will send it every day in selected time. P.S. You can turn it On/Off in System Settings"
        default: return ""
        }
    }
}

