//
//  SelectTimeViewCell.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 26/01/2019.
//  Copyright © 2019 Divine App. All rights reserved.
//

import UIKit

class SelectTimeViewCell: UITableViewCell {
    
    
    @IBOutlet weak var selectTimeCellLabel: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var pickerHeightConstraint: NSLayoutConstraint!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		timePicker.datePickerMode = UIDatePicker.Mode.time
	}
	
    var isExpanded:Bool = false {
        didSet {
            if !isExpanded {
                self.pickerHeightConstraint.constant = 0.0
            } else {
                self.pickerHeightConstraint.constant = 156.0
            }
        }
    }

}
