//
//  Date+DateFormatter.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

var date = Date()

extension Date {
    func getNextDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    func getPreviousDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
}

func formatDate(_ date: Date, textLabel: UILabel) {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_EN")
    dateFormatter.setLocalizedDateFormatFromTemplate("d MM yy")
    textLabel.text = "\(dateFormatter.string(from: date))"
}
