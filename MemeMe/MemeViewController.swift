//
//  ViewController.swift
//  MemeMe
//
//  Created by Mufeed AlMatar on 2019-03-13.
//  Copyright © 2019 Mufeed AlMatar. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    static let TopInitText = "TOP"
    static let BottomInitText = "BOTTOM"
    
    var meme: Meme?
    
    var topTextFieldDelegate = MemeTextFieldDelegate()
    var bottomTextFieldDelegate = MemeTextFieldDelegate()
    
    @IBOutlet weak var pickCameraButton: UIBarButtonItem!
    @IBOutlet weak var pickAlbumButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
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
        removeKeyboardObservers()
    }

    // MARK: Configure GUI
    func configureUI() {
        //Initilize Delegates
        topTextFieldDelegate.defaultText = MemeViewController.TopInitText
        bottomTextFieldDelegate.defaultText = MemeViewController.BottomInitText
        
        //Setup Text Fileds
        setupTextField(topTextField, topTextFieldDelegate)
        setupTextField(bottomTextField, bottomTextFieldDelegate)
        
        //Reset View
        reset()
    }
    
    func setupTextField(_ textField: UITextField,_ memeDelegate: MemeTextFieldDelegate) {
        //Setup Text fields font
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.black,
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            .strokeWidth: -4.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = memeDelegate
    }
    
    @IBAction func reset() {
        topTextField.text = MemeViewController.TopInitText
        bottomTextField.text = MemeViewController.BottomInitText
        shareButton.isEnabled = false
        imageView.image = nil
        meme = nil
    }
    
    // MARK: Saving and Sharing Memes
    @IBAction func share() {
        let memedImage = generateMemedImage()
        let items = [memedImage]
        let activityView = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityView.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
            }
        }
        present(activityView, animated: true)
    }
    
    //Save a meme
    func save() {
        // Create the meme
        meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
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
