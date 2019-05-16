//
//  MainCoordinator.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//
import UIKit

let customTintColor = UIColor.nightBlue

class MainCoordinator: Coordinator {
    
    var presenter: PresenterViewController
    let cardsVCTitle = NSLocalizedString("Say more good words", comment: "")
    
	init(presenter: PresenterViewController) {
        self.presenter = presenter
        presenter.navigationBar.setBackgroundImage(UIImage(), for: .default)
        presenter.navigationBar.shadowImage = UIImage()
        presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.nightBlue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
    }
    func start() {
        let viewController = ViewController.instantiate()
        viewController.coordinator = self
        presenter.pushViewController(viewController, animated: true)
    }
    func visualBoardSubscription() {
        let visualBoardViewController = VisualBoardViewController.instantiate()
        visualBoardViewController.coordinator = self
        presenter.pushViewController(visualBoardViewController, animated: true)
    }
    func cardsVCSubscription() {
        let vc = UserAffirmationsViewController.instantiate()
        vc.coordinator = self
        vc.title = cardsVCTitle
        presenter.pushViewController(vc, animated: true)
    }
}

