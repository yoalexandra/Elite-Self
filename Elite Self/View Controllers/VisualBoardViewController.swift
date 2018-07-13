//
//  VisualBoardViewController.swift
//  Elite Self
//
//  Created by Администратор on 14/04/2018.
//  Copyright © 2018 alejandra. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

class VisualBoardViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photoLibrary = [PhotoLibrary]()
    let tintButtonColor = UIColor(hue: 0.62, saturation: 0.5, brightness: 0.206, alpha: 1.0)
    var isSelectedCell = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewVC()
        navigatonBarButtons()
        setNavigationBarLargeTitle()
        savedCollectionPhoto()
    }
    
    func setupCollectionViewVC() {
        collectionView?.backgroundColor = tintButtonColor
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    // MARK: - Navigation Bar
    func navigatonBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVB))
        navigationItem.rightBarButtonItem?.tintColor = tintButtonColor
        navigationItem.leftBarButtonItem?.tintColor = tintButtonColor
    }
    @objc func addNewPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    @objc func dismissVB() {
        dismiss(animated: true, completion: nil)
        savePhotoCollection()
    }
    func setNavigationBarLargeTitle() {
        navigationItem.title = "Visualize often"
        navigationItem.largeTitleDisplayMode = .always
    }
    // MARK: - CollectionView
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
        cell.delegate = self
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell
        if isSelectedCell {
            cell?.isEditing = true
        } else {
            cell?.deleteViewCellBtn.isHidden = true
        }
        isSelectedCell = !isSelectedCell
    }
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        let photo = PhotoLibrary(image: image) //, caption: "Your caption") will use it in next update
        photoLibrary.append(photo!)
        self.collectionView?.reloadData()
        savePhotoCollection()
        dismiss(animated: true)
    }
    // MARK: - FileManager saving images
    private func savePhotoCollection() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(photoLibrary, toFile: PhotoLibrary.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Photo succseffully saved", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save photos", log: OSLog.default, type: .error)
        }
    }
    // Load Images
    private func loadPhotoCollection() -> [PhotoLibrary]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: PhotoLibrary.ArchiveURL.path) as? [PhotoLibrary]
    }
    // Load any saved photos
    func savedCollectionPhoto() {
        if let savePhoto = loadPhotoCollection() {
            photoLibrary += savePhoto
        }
    }
    
    override var prefersStatusBarHidden: Bool { return false }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
} // End class

// MARK: - Extend ViewController, UICollectionViewDelegateFlowLayout
extension VisualBoardViewController: UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}
// MARK: conform delegate PhotoCell protocol
extension VisualBoardViewController: PhotoCellDelegate {
    func delete(cell: PhotoCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            photoLibrary.remove(at: indexPath.item)
            self.collectionView?.deleteItems(at: [indexPath])
        }
        savePhotoCollection()
    }
}
























