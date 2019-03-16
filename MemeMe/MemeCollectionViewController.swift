//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Mufeed AlMatar on 15/03/2019.
//  Copyright © 2019 Mufeed AlMatar. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
}
