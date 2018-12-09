//
//  CardsCollectionViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 01/10/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
//TODO: Global refactoring , check if you can make some methods reusable!
class CardsCollectionViewController: UICollectionViewController, StoryboardedVCs {
    
    weak var coordinator: MainCoordinator?
    var affirmations = [String]()
    let editButtonTitle = NSLocalizedString("Save", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewVC()
        addNavigatonBarButtons()
        parseJSON()
    }
    func setupCollectionViewVC() {
        collectionView?.backgroundColor = UIColor.init(hexValue: "#E1CBCD", alpha: 1.0)
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout,
            let collectionView = collectionView {
            let width = collectionView.frame.width - 20
            flowLayout.estimatedItemSize = CGSize(width: width, height: 200)
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
    func parseJSON() {
        //Parse JSON to UserNotification content
        guard let path = Bundle.main.path(forResource: "quotes", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let jsonDict = json as! Dictionary<String, Array<String>>
            for (_ , value) in jsonDict {
                for item in value {
                    affirmations.append(item)
                }
            }
        } catch {
            print("Fatal error: \(error.localizedDescription)")
        }
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

