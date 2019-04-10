//
//  CardsCollectionViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
//TODO: Global refactoring , check if you can make some methods reusable!
//TODO: save userPhrases with CoreData  // CustomAffirmations - entity phrase
class CardsCollectionViewController: UICollectionViewController, StoryboardedVCs {
	
    // Routing
    weak var coordinator: MainCoordinator?
    // Cards items // tmp data
    var affirmations = [
                        "THANK YOU! Thank whatever that's happening for helping me to evolve",
                        "The best is yet to come",
                        "Amazing things are keeping to happen today",
                        "Think beautiful thoughts",
                        "Be the energy you want to attract",
                        "My Life just keeps getting better!",
                        "Breathe through all changes. You're exactly where you should be in your transformation",
                        "Think positive",
                        "Every month of my Life is a period of magnificent transformation",
                        "My Life is beautiful"]
    let editButtonTitle = NSLocalizedString("Save", comment: "")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - viewDidLoad - in case your lost lol I know you will
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewVC()
        addNavigatonBarButtons()
    }
    // CollectionCell sizing
    func setupCollectionViewVC() {
        collectionView?.backgroundColor = UIColor.deepRed//init(hexValue: "#E1CBCD", alpha: 1.0)
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = collectionView {
            let width = collectionView.frame.width - 20
            flowLayout.estimatedItemSize = CGSize(width: width, height: 150)
        }
    }
    // MARK: - Navigation Bar
    func addNavigatonBarButtons() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = editButtonItem
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(dismissEWVC))
		navigationItem.rightBarButtonItem?.setBackgroundImage(UIImage(named: "home_screen_button_icon"), for: .normal, barMetrics: .default)
        navigationItem.leftBarButtonItem?.tintColor = .white
	
    }
    // Return to main screen
    @objc func dismissEWVC() {
        coordinator?.presenter.popToRootViewController(animated: true)
    }
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return affirmations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "affirmationCell", for: indexPath) as? AffirmationViewCell else {
            fatalError("The dequeued cell is not instance of AffirmationViewCell")
        }
        cell.affirmationViewText.text = affirmations[indexPath.item]
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        for visibleCell in collectionView.visibleCells {
            
            guard let cell = visibleCell as? AffirmationViewCell else { return }
            
            if editing {
                self.editButtonItem.title = editButtonTitle
                cell.affirmationViewText.isUserInteractionEnabled = true
                cell.addDoneKeyboardButton()
                cell.affirmationViewText.becomeFirstResponder()
            } else {
                //TODO: Save custom affirmation
                print("Text should be saved in new array!")
            }
        }
    }
}


