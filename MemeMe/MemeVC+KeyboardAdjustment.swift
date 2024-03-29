//
//  MemeVC+KeyboardAdjustment.swift
//  MemeMe
//
//  Created by Mufeed AlMatar on 14/03/2019.
//  Copyright © 2019 Mufeed AlMatar. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController {
    // MARK: Keyboard Adjustment

    //Call this method on viewWillAppear
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Call this method on viewWillDisappear
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        if isKeyboardOverUI(notification, self.getActiveUIControl()) {
            moveFrameUp(keyboardHeight: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        moveFrameBack()
    }
    
    func moveFrameUp(keyboardHeight: CGFloat) {
        self.view.frame.origin.y =  -keyboardHeight
    }
    
    func moveFrameBack() {
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func isKeyboardOverUI(_ notification: Notification, _ control: UIControl?) -> Bool {
        if let control = control {
            let keyboardHeight = getKeyboardHeight(notification)
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
    
}
