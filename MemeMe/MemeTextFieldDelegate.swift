//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Mufeed AlMatar on 13/03/2019.
//  Copyright © 2019 Mufeed AlMatar. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    var defaultText: String!
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // When a user taps inside a textfield,
        // the default text should clear.
        if textField.text == defaultText {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // When a user presses return, the keyboard should be dismissed
        textField.resignFirstResponder()
        return true
    }
}
