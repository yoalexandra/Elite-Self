//
//  MainCoordinator.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//
import UIKit

let customTintColor = UIColor.deepRed 
let customFont = UIFont(name: "Lobster", size: 24.0)
let pPolicyVCTitle = NSLocalizedString("Privacy Policy", comment: "")

class MainCoordinator: Coordinator {
    
    var presenter: PresenterViewController
	var newDate: Date?
    let settingsVCTitle = NSLocalizedString("Settings", comment: "")
    let cardsVCTitle = NSLocalizedString("Say more good words", comment: "")
    
	init(presenter: PresenterViewController) {
        self.presenter = presenter
        presenter.navigationBar.setBackgroundImage(UIImage(named: "navbar_background_icon"), for: .default)
        //presenter.navigationBar.shadowImage = UIImage()
        presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.white, NSAttributedString.Key.font: customFont!]
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
        let cardsViewController = CardsCollectionViewController.instantiate()
        cardsViewController.coordinator = self
        cardsViewController.title = cardsVCTitle
        presenter.pushViewController(cardsViewController, animated: true)
    }

}

