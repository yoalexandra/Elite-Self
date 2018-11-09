//
//  Coordinator.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

protocol Coordinator {
    var presenter: PresenterViewController { get set }
    func start()
}

