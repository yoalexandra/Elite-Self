//
//  VisualBoardViewController.swift
//  Elite Self
//
//  Created by Alexandra Beznosova on 14/04/2018.
//  Copyright © 2018 Divine App. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

class VisualBoardViewController: UICollectionViewController, StoryboardedVCs {
    
    weak var coordinator: MainCoordinator?
    
    var photoLibrary = [PhotoLibrary]()
    var isSelectedCell = true
   
    // MARK: - Localizable strings properties
    let largeTitleText = NSLocalizedString("Visualize often", comment: "")
    let alertTitleText = NSLocalizedString("Delete this picture from your Visual Board?", comment: "")
    let alertMessageText = NSLocalizedString("Are you sure you want to delete this picture?", comment: "")
    let alertComformActionTitle = NSLocalizedString("Yes", comment: "")
    let alertCancelActionTitle = NSLocalizedString("No", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        addNavigatonBarButtons()
        setupCollectionViewVC()
        addLongPressGestureRecognizer()
        savedCollectionPhoto()
    }
	
	
	// MARK: - FileManager saving & retrieve images
	func savePhotoCollection() {
		let url = URL(fileURLWithPath: PhotoLibrary.ArchiveURL.path)
		print(url)
		do {
			let encodedData = try PropertyListEncoder().encode(photoLibrary)
			let data  = try NSKeyedArchiver.archivedData(withRootObject: encodedData, requiringSecureCoding: false)
			
			try data.write(to: url, options: [.atomic])
			os_log("Photo succseffully saved", log: OSLog.default, type: .debug)
		} catch {
			os_log("Failed to save photos", log: OSLog.default, type: .error)
		}
	}
	// Load Photos
	func loadPhotoCollection() -> [PhotoLibrary]? {
		
		let decoder = PropertyListDecoder()
		
		guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: PhotoLibrary.ArchiveURL.path) as? Data else { return nil }
		do {
		  let photos = try decoder.decode([PhotoLibrary].self, from: data)
		  return photos
		} catch {
		  print("Retrieve Failed")
		  return nil
		}
		
	}
	// Load any saved photos
	func savedCollectionPhoto() {
		if let savePhoto = loadPhotoCollection() {
			photoLibrary += savePhoto
		}
	}
 
    override var prefersStatusBarHidden: Bool { return false }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}

// MARK: - CollectionView data source
extension VisualBoardViewController {
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return photoLibrary.count
	}
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
			fatalError("The dequeued cell is not instance of PhotoCell")
		}
		let image = photoLibrary[indexPath.item]
		cell.photoView.image = image.image
		return cell
	}
}

// MARK: -  UICollectionViewDelegateFlowLayout
extension VisualBoardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

//MARK: UIImagePickerControllerDelegate
extension VisualBoardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		// Dismiss the picker if the user canceled.
		dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		guard let image = info[.editedImage] as? UIImage else { return }
		let photo = PhotoLibrary(image: image)
		photoLibrary.append(photo!)
		self.collectionView?.reloadData()
		savePhotoCollection()
		dismiss(animated: true)
	}
}

private extension VisualBoardViewController {
	func setupCollectionViewVC() {
		collectionView?.backgroundColor = UIColor.white
		collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
	}
	// MARK: - Navigation Bar
	func addNavigatonBarButtons() {
		navigationItem.title = largeTitleText
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(dismissVB))
		navigationItem.setHidesBackButton(true, animated: false)
		navigationItem.rightBarButtonItem?.setBackgroundImage(UIImage(named: "home_screen_button_icon"), for: .normal, barMetrics: .default)
		navigationItem.rightBarButtonItem?.tintColor = UIColor.nightBlue
		navigationItem.leftBarButtonItem?.tintColor = UIColor.nightBlue
	}
	@objc func addNewPhoto() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
	}
	@objc func dismissVB() {
		savePhotoCollection()
		coordinator?.presenter.popToRootViewController(animated: true)
	}
	// MARK: - UILongPressGestureRecognizer
	func addLongPressGestureRecognizer() {
		let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.receiveLongPress(gestureRecognizer:)))
		collectionView?.addGestureRecognizer(longPressRecognizer)
	}
	//MARK: - Deleting CollectionViewCell with longPressGestureRecognizer
	@objc func receiveLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
		let targetPress = gestureRecognizer.location(in: collectionView)
		guard let tappedIndexPath = collectionView?.indexPathForItem(at: targetPress), let tappedCell = collectionView?.cellForItem(at: tappedIndexPath) else { return }
		UIView.animate(withDuration: 0.3, delay: 0.0, options: [.repeat], animations: {
			tappedCell.transform = CGAffineTransform(rotationAngle: 0.03)
			tappedCell.transform = CGAffineTransform(rotationAngle: -0.03)
		}, completion: nil)
		deletePhoto(withCell: tappedCell, atIndexPath: tappedIndexPath)
	}
	func deletePhoto(withCell cell: UICollectionViewCell, atIndexPath indexPath: IndexPath) {
		let confirmDeleting = UIAlertController(title: alertTitleText, message: alertMessageText, preferredStyle: .actionSheet)
		let deleteAction = UIAlertAction(title: alertComformActionTitle, style: .destructive, handler: { action in
			self.photoLibrary.remove(at: indexPath.row)
			self.collectionView?.deleteItems(at: [indexPath])
			self.savePhotoCollection()
		})
		let cancelAction = UIAlertAction(title: alertCancelActionTitle, style: .cancel, handler: { action in
			UIView.animate(withDuration: 0.01, delay: 0.0, options: [], animations: {
				cell.transform = CGAffineTransform.identity
			}, completion: nil)
		})
		confirmDeleting.addAction(deleteAction)
		confirmDeleting.addAction(cancelAction)
		if let popOver = confirmDeleting.popoverPresentationController {
			popOver.sourceView = cell
			if let cell = cell as? PhotoCell {
				let imageFrame = cell.photoView.frame
				let popOverX = imageFrame.origin.x + imageFrame.size.width / 2
				let popOverY = imageFrame.origin.y + imageFrame.size.height / 2
				popOver.sourceRect = CGRect(x: popOverX, y: popOverY, width: 0.0, height: 0.0)
			}
		}
		present(confirmDeleting, animated: true, completion: nil)
	}

}
