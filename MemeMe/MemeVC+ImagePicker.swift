//
//  MemeVC+ImagePicker.swift
//  MemeMe
//
//  Created by Mufeed AlMatar on 14/03/2019.
//  Copyright © 2019 Mufeed AlMatar. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    enum ImageSourceType: Int {
        case camera = 0, album
    }
    
    // MARK: Picking and displaying an image
    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        // Determine source type: Camera or Album form button tag
        var sourceType: UIImagePickerController.SourceType
        switch(ImageSourceType(rawValue: sender.tag)!) {
        case .camera:
            sourceType = UIImagePickerController.SourceType.camera
        case .album:
            sourceType = UIImagePickerController.SourceType.photoLibrary
        }
        
        // Initialize and show the image picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // User Picked an image
        dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            shareButton.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //User cancel image picked
        dismiss(animated: true, completion: nil)
    }
}
