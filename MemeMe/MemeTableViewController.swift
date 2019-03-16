//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Mufeed AlMatar on 16/03/2019.
//  Copyright © 2019 Mufeed AlMatar. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    static let CellIdentifier = "MemeTableCell"
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        self.title = "Sent Memes"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMemeEditor))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func showMemeEditor() {
        let memeEditor = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeViewController
        self.present(memeEditor, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemeTableViewController.CellIdentifier)
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell?.textLabel?.text = meme.topText + "..." + meme.bottomText
        cell?.imageView?.image = meme.memedImage
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(memeDetailVC, animated: true)
    }
    
    //Define the height of the cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}
