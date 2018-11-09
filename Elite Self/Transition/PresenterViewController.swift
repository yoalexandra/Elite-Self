//
//  PresenterViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 09/11/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit

class PresenterViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}
extension PresenterViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return FadeAnimation(presenting: true)
        } else {
            return FadeAnimation(presenting: false)
        }
    }
}

