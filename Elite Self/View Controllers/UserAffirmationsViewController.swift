//
//  UserAffirmationsViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 16/05/2019.
//  Copyright © 2019 Divine App. All rights reserved.
//

import UIKit

class UserAffirmationsViewController: UIViewController, StoryboardedVCs {

	@IBOutlet weak var tableView: UITableView!
	
	weak var coordinator: MainCoordinator?
	let editButtonTitle = NSLocalizedString("Save", comment: "")
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	let textView = UITextView(frame: CGRect.zero)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		addNavigatonBarButtons()
		
    }
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "bounds" {
			if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
				let margin:CGFloat = 10.0
				
				textView.frame = CGRect(x: rect.origin.x + margin,y: rect.origin.y + margin, width: rect.width - 2 * margin, height:  rect.height / 2)
				textView.bounds = CGRect(
					x: rect.origin.x + margin,
					y: rect.origin.y + margin,
					width: rect.width - 2 * margin,
					height:  rect.height / 2)
			}
		}
	}

}

private extension UserAffirmationsViewController {
	// MARK: - Navigation Bar
	func addNavigatonBarButtons() {
		
		navigationItem.setHidesBackButton(true, animated: false)
		let homeScreenButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(dismissUAVC))
		homeScreenButton.setBackgroundImage(UIImage(named: "home_screen_button_icon"), for: .normal, barMetrics: .default)
		
		let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(showAlert))
		
		
		homeScreenButton.tintColor = .nightBlue
		addButton.tintColor = .nightBlue
		navigationItem.leftBarButtonItem?.tintColor = .nightBlue
		
		navigationItem.rightBarButtonItems = [homeScreenButton, addButton]
	}
	// Return to main screen
	@objc func dismissUAVC() {
		coordinator?.presenter.popToRootViewController(animated: true)
	}
	// Save it to crad collection
	@objc func showAlert() {
		let alertController = UIAlertController(title: "\n\n\n", message: nil, preferredStyle: .alert)
		
		textView.backgroundColor = UIColor.clear
		alertController.view.addSubview(textView)
		
		alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
		
		let saveAction =  UIAlertAction(title: "OK", style: .default, handler: { _ in
			alertController.view.removeObserver(self, forKeyPath: "bounds")
		})
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {_ in
			alertController.view.removeObserver(self, forKeyPath: "bounds")
		})
		
		alertController.addAction(cancelAction)
		alertController.addAction(saveAction)
		
		present(alertController, animated: true, completion: nil)
	}
}
