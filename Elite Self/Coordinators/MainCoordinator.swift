//
//  MainCoordinator.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//
import UIKit

let customTintColor = UIColor.deepRed1 //UIColor.init(hexValue: "#01739a", alpha: 1.0)  // old #204764
let customFont = UIFont(name: "Lobster", size: 34.0)
let pPolicyVCTitle = NSLocalizedString("Privacy Policy", comment: "")

class MainCoordinator: Coordinator {
    
    var presenter: PresenterViewController
	var newDate: Date?
    let settingsVCTitle = NSLocalizedString("Settings", comment: "")
    let cardsVCTitle = NSLocalizedString("Say more good words", comment: "")
    
	init(presenter: PresenterViewController) {
        self.presenter = presenter
		
        presenter.navigationBar.setBackgroundImage(UIImage(), for: .default)
        presenter.navigationBar.shadowImage = UIImage()
		
        //presenter.navigationBar.backgroundColor = .black
        presenter.navigationBar.prefersLargeTitles = true
        presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  customTintColor, NSAttributedString.Key.font: UIFont(name: "Lobster", size: UIFont.labelFontSize)!]
        presenter.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: customTintColor, NSAttributedString.Key.font: customFont!]

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
    func goasVClSubscription() {
        let goalsViewController = GoalsViewController.instantiate()
        goalsViewController.coordinator = self
        presenter.pushViewController(goalsViewController, animated: true)
    }
    func cardsVCSubscription() {
        let cardsViewController = CardsCollectionViewController.instantiate()
        cardsViewController.coordinator = self
        cardsViewController.title = cardsVCTitle
        presenter.pushViewController(cardsViewController, animated: true)
    }
    func settingsVCSubscription() {
        let settingsViewController = SettingsTableViewController.instantiate()

        settingsViewController.coordinator = self
		
        settingsViewController.title = settingsVCTitle
        presenter.pushViewController(settingsViewController, animated: true)
    }
    func ppVCSubscription() {
        let ppViewController = PrivacyViewController.instantiate()
        ppViewController.coordinator = self
        ppViewController.title = pPolicyVCTitle
        presenter.pushViewController(ppViewController , animated: true)
    }
}


/*
 
 colors :
 
 #5900e2
 #5800dd
 ////////
 #051333  dark blue 0 too dark
 #01739a
 #062651 dark blue 1 lighter
 #0e345c nightblue lighter
 for star
 #471370 purple
 */
