//
//  ManageNotificationCell.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 28/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class ManageNotificationCell: UITableViewCell {
    
    @IBOutlet weak var timePicker: UIDatePicker!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    func newTimeNotification(selectedHour: Int, selectedMin: Int) {
        //timePicker.date = selectedHour
    }
    
}
