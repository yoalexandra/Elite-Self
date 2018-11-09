//
//  MainCoordinator.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//
import UIKit

let customTintColor = UIColor.init(hexValue: "#204764", alpha: 1.0)

class MainCoordinator: Coordinator {
    
    var presenter: PresenterViewController
    
    init(presenter: PresenterViewController) {
        self.presenter = presenter
        presenter.navigationBar.setBackgroundImage(UIImage(), for: .default)
        presenter.navigationBar.shadowImage = UIImage()
        presenter.navigationBar.backgroundColor = .clear
        presenter.navigationBar.prefersLargeTitles = true
        presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  customTintColor!]
        presenter.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: customTintColor!]

    }
    func start() {
        let viewController = ViewController.instantiate()
        viewController.coordinator = self
        presenter.pushViewController(viewController, animated: true)
    }
    
    func visualBoardSubscription() {
        let visualBoardViewController = VisualBoardViewController.instantiate()
        visualBoardViewController.coordinator = self
        presenter.pushViewController( visualBoardViewController, animated: true)
    }
    
    func goasVClSubscription() {
        let goalsViewController = GoalsViewController.instantiate()
        goalsViewController.coordinator = self
        presenter.pushViewController(goalsViewController, animated: true)
    }
  
    func cardsVCSubscription() {
        let cardsViewController = CardsCollectionViewController.instantiate()
        cardsViewController.coordinator = self
        cardsViewController.title = "Affirm"
        presenter.pushViewController(cardsViewController, animated: true)
    }
    func settingsVCSubscription() {
        let settingsViewController = SettingsTableViewController.instantiate()
        settingsViewController.coordinator = self
        settingsViewController.title = "Settings"
        presenter.pushViewController(settingsViewController, animated: true)
    }
    func ppVCSubscription() {
        let ppViewController = PrivacyViewController.instantiate()
        ppViewController.coordinator = self
        ppViewController.title = "Privacy Policy"
        presenter.pushViewController(ppViewController , animated: true)
    }
}

