//
//  AccountViewController.swift
//  FLP
//
//  Created by Bob De Kort on 3/7/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit
import MessageUI

class AccountViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {
    
    // MARK: Fileprivate Variables
    
    fileprivate let tourCellId = "tourCellId"
    
    // MARK: variables
    
    var tours: [Tour]? {
        didSet{
            collectionView?.reloadData()
        }
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()

    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiService.sharedInstance.getProfile { (tours) in
            self.tours = tours
        }
        
        collectionView!.contentInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        
        self.title = "My Tours"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton]
        
        collectionView?.backgroundColor = .white
        collectionView?.register(MyTourCollectionViewCell.self, forCellWithReuseIdentifier: tourCellId)
        
    }
    
    func handleMore() {
        //show menu
        settingsLauncher.showSettings()
        settingsLauncher.navigationController = self.navigationController
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["dekort.bob101@gmail.com"])
            mail.setSubject("FEEDBACK: ")
            mail.setMessageBody("Please enter your feedback, concerns, questions, etc below: ", isHTML: false)
            
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "Could not open mail", message: "This device is not setup to send emails. Please enable this to continue sending us feedback", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let tours = tours {
            return tours.count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tourCellId, for: indexPath) as! MyTourCollectionViewCell
        if let tours = tours {
            cell.tour = tours[indexPath.item]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50, height: 140)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
