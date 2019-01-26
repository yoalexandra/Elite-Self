//
//  CardsCollectionViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import CoreData
//TODO: Global refactoring , check if you can make some methods reusable!
//TODO: save userPhrases with CoreData  // CustomAffirmations - entity phrase
class CardsCollectionViewController: UICollectionViewController, StoryboardedVCs {
    // Property to switch on if user setup custom affirmation
    var isUserPhraseSetup = false
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
        //convertToJSONArray(moArray: [Affirmations])
    }
    // CollectionCell sizing
    func setupCollectionViewVC() {
        collectionView?.backgroundColor = UIColor.init(hexValue: "#E1CBCD", alpha: 1.0)
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
        let doneButton = UIBarButtonItem(title: backButtonTitle, style: .done, target: self, action: #selector(dismissEWVC))
        navigationItem.rightBarButtonItems = [doneButton]//, editButton]
        navigationItem.leftBarButtonItem?.tintColor = customTintColor
        navigationItem.rightBarButtonItem?.tintColor = customTintColor
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
	func convertToJSONArray(moArray: [NSManagedObject]) -> Any {
		var jsonArray: [[String: Any]] = []
		for item in moArray {
			var dict: [String: Any] = [:]
			for attribute in item.entity.attributesByName {
				//check if value is present, then add key to dictionary so as to avoid the nil value crash
				if let value = item.value(forKey: attribute.key) {
					dict[attribute.key] = value
				}
			}
			jsonArray.append(dict)
		}
		return jsonArray
	}
}


