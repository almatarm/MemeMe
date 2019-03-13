//
//  ViewController.swift
//  MemeMe
//
//  Created by Mufeed AlMatar on 2019-03-13.
//  Copyright © 2019 Mufeed AlMatar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    enum ImageSourceType: Int {
        case camera = 0, album
    }
    
    @IBOutlet weak var pickCameraButton: UIBarButtonItem!
    
    @IBOutlet weak var pickAlbumButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickCameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

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

    // MARK: UIImagePickerControllerDelegate methods
    // User Picked an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
    }
    
    //User cancel image picked
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Canceled")
        dismiss(animated: true, completion: nil)
    }
}

