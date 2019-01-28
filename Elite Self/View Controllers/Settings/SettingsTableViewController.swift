//
//  SettingsTableViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

protocol SettingsTableViewControllerDelegate: class {
	func newDateIsSelected(newDate: Date, isSelected: Bool)
}

class SettingsTableViewController: UITableViewController, StoryboardedVCs {
    
    weak var coordinator: MainCoordinator?
	// Properties to send data to root ViewController
	weak var delegate: SettingsTableViewControllerDelegate?
	
    var expandedRows = Set<Int>()
	let titleForHeaderInSection1 = NSLocalizedString("Manage notifications", comment: "")
	let titleForFooterInSection0 = NSLocalizedString("Privacy policy and support", comment: "")
	let titleForFooterInSection1 = NSLocalizedString("Schedule notifications, select start time to get your positive words. Elite Self will send it every day 3 times form selected time plus 4 and  8 hours. P.S. You can turn it On/Off in System Settings", comment: "")
	let selectTimeCellTitle = NSLocalizedString("Select time", comment: "")
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
            cell?.textLabel?.text = pPolicyVCTitle
            return cell!
        }
        // Expanable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectTime" , for: indexPath) as! SelectTimeViewCell
            cell.selectTimeCellLabel.textColor = customTintColor
			cell.selectTimeCellLabel.text = selectTimeCellTitle
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
			
			let date = cell.timePicker.date
			delegate?.newDateIsSelected(newDate: date, isSelected: true)
			
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
        case 0:  return  pPolicyVCTitle
        case 1:  return  titleForHeaderInSection1
        default: return ""
        }
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:  return titleForFooterInSection0
        case 1:  return titleForFooterInSection1
        default: return ""
        }
    }
}

