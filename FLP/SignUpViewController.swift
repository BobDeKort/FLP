//
//  SignUpViewController.swift
//  FLP
//
//  Created by Bob De Kort on 3/15/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func signUpPressed(_ sender: Any) {
        if passwordField.text != nil && confirmPasswordField.text != nil && passwordField.text == confirmPasswordField.text {
            if let email = emailField.text, let username = usernameField.text, let password = passwordField.text {
                ApiService.sharedInstance.signUp(email: email, password: password, username: username, completionHandler: { (succes) in
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
