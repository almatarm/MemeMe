//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Mufeed AlMatar on 15/03/2019.
//  Copyright © 2019 Mufeed AlMatar. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    static let CellIdentifier = "MemeCollectionCellIdentifier"
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMemeEditor))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    @objc func showMemeEditor() {
        let memeEditor = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeViewController
        self.present(memeEditor, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            MemeCollectionViewController.CellIdentifier, for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.memeImage.image = meme.memedImage
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MemeTableViewController.CellIdentifier)
//        let meme = self.memes[(indexPath as NSIndexPath).row]
//
//        cell?.textLabel?.text = meme.topText + "..." + meme.bottomText
//        cell?.imageView?.image = meme.memedImage
//
//        return cell!
//    }
//
//    //Define the height of the cell
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 72
//    }
//
}
