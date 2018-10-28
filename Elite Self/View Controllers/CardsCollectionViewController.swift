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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigatonBarButtons()
        parseJSON()
    }
    
    // MARK: - Navigation Bar
    func addNavigatonBarButtons() {
        navigationItem.setHidesBackButton(true, animated: false)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEWVC))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editCells))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEWVC))
        navigationItem.rightBarButtonItems = [ doneButton, editButton]
        editButton.tintColor = customTintColor
        navigationItem.rightBarButtonItem?.tintColor = customTintColor
    }
    @objc func dismissEWVC() {
        // TODO: Custom transition
        coordinator?.presenter.popToRootViewController(animated: true)
    }
    @objc func editCells() {
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
            fatalError("The dequeued cell is not instance of AffirmationCollectionViewCell")
        }
        cell.affirmationViewText.text = affirmations[indexPath.item]
        return cell
    }

}
