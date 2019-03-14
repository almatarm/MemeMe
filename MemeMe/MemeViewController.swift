//
//  ViewController.swift
//  MemeMe
//
//  Created by Mufeed AlMatar on 2019-03-13.
//  Copyright © 2019 Mufeed AlMatar. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var keyboardHeight : CGFloat = 226
    
    enum ImageSourceType: Int {
        case camera = 0, album
    }
    
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }

    static let TopInitText = "TOP"
    static let BottomInitText = "BOTTOM"
    
    var topTextFieldDelegate = MemeTextFieldDelegate()
    var bottomTextFieldDelegate = MemeTextFieldDelegate()
    
    @IBOutlet weak var pickCameraButton: UIBarButtonItem!
    @IBOutlet weak var pickAlbumButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Do we have a camera
        pickCameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        unsubscribeFromKeyboardNotifications()
    }

    // MARK: Configure GUI
    func configureUI() {
        //Setup Text fields font
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -4.0
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.text = MemeViewController.TopInitText
        bottomTextField.text = MemeViewController.BottomInitText
        
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
        //Text Fields delegates
        topTextFieldDelegate.defaultText = MemeViewController.TopInitText
        bottomTextFieldDelegate.defaultText = MemeViewController.BottomInitText
        
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
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
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //User cancel image picked
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Keyboard Hide/Show
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        self.keyboardHeight = self.getKeyboardHeight(notification)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.height != 0 && self.keyboardHeight > keyboardSize.height {
                keyboardHeight = keyboardSize.height
            }
            if isKeyboardOverUI(notification, self.getActiveUIControl()) {
                moveFrameUp()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        moveFrameBack()
    }
    
    func moveFrameUp() {
        if self.view.frame.origin.y != self.view.frame.origin.y - keyboardHeight {
            self.view.frame.origin.y =  -keyboardHeight
        }
    }
    
    func moveFrameBack() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func isKeyboardOverUI(_ notification: Notification, _ control: UIControl?) -> Bool {
        if let control = control {
            keyboardHeight = getKeyboardHeight(notification)
            return control.frame.maxY > self.view.frame.height - keyboardHeight + 32
        }
        return false
    }
    
    func getActiveUIControl() -> UIControl? {
        for subview in view.subviews as [UIView] {
            if let control = subview as? UIControl {
                if control.isFirstResponder {
                    return control
                }
            }
        }
        return nil
    }
    
    // MARK: Saving and Sharing Memes
    @IBAction func save() {
        // Create the meme
//        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        imageView.image = generateMemedImage()
    }
    
    func generateMemedImage() -> UIImage {
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage
    }
}
