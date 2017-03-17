//
//  LoginViewController.swift
//  FLP
//
//  Created by Bob De Kort on 3/15/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func loginPressed(_ sender: Any) {
        if let password = passwordField.text, let email = emailField.text {
            if password == "" || email == "" {
                print("Please fill out email and password")
                // TODO: Show alert
            } else {
                ApiService.sharedInstance.login(email: email, password: password, completionHandler: { (succes) in
                    if succes {
                        let tabBarController = UITabBarController()
                        
                        // FeaturedController
                        let layout = UICollectionViewFlowLayout()
                        let featuredController = UINavigationController(rootViewController: FeaturedController(collectionViewLayout: layout))
                        
                        featuredController.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(named:"featured"), tag: 1)
                        
                        UINavigationBar.appearance().barTintColor = UIColor.projectColor()
                        
                        // AcountController
                        
                        let accountLayout = UICollectionViewFlowLayout()
                        accountLayout.minimumInteritemSpacing = 20
                        
                        let accountController = UINavigationController(rootViewController: AccountViewController(collectionViewLayout: accountLayout))
                        accountController.tabBarItem = UITabBarItem(title: "My Tours", image: UIImage(named:"myTours"), tag: 2)
                        
                        
                        let tabbarControllers = [featuredController, accountController]
                        tabBarController.viewControllers = tabbarControllers
                        
                        self.navigationController?.pushViewController(tabBarController, animated: true)
                    } else {
                        print("Something went wrong, Please Try agian")
                    }
                    
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
