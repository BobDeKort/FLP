//
//  LoginViewController.swift
//  whale-ios-BobDeKort
//
//  Created by Bob De Kort on 3/20/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginPressed(_ sender: Any) {
        if let email = usernameTextField.text {
            guard email != "" else {
                // present alert
                print("email empty")
                presentAlert(message: "Please fill in your email")
                return
            }
            if let password = passwordTextField.text {
                guard password != "" else {
                    // present alert
                    print("password empty")
                    presentAlert(message: "Please fill in you password")
                    return
                }
                ApiService.sharedInstance.login(email: email, password: password, completionHandler: { (result) in
                    if result {
                        self.loginSuccess()
                    } else {
                        self.presentAlert(message: "Something went wrong Please try again")
                    }
                })
            } else {
                presentAlert(message: "Please fill in you password")
            }
        } else {
            presentAlert(message: "Please fill in your email")
        }
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        let vc = SignUpViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
   
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true 
        setupButtons()
        setupTextfields()
    }
    
    func setupButtons(){
        // Login Button
        LoginButton.layer.borderWidth = 1
        LoginButton.layer.borderColor = UIColor.projectColor().cgColor
        LoginButton.layer.cornerRadius = LoginButton.frame.height/4
        LoginButton.setTitleColor(.white, for: .normal)
        LoginButton.backgroundColor = UIColor.projectColor()
        
        // SignupButton
        signUpButton.layer.borderColor = UIColor.projectColor().cgColor
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.cornerRadius = signUpButton.frame.height/4
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = UIColor.projectColor()
    }
    
    func setupTextfields(){
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.projectColor().cgColor
        usernameTextField.layer.cornerRadius = usernameTextField.frame.height / 4
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.projectColor().cgColor
        passwordTextField.layer.cornerRadius = usernameTextField.frame.height / 4
    }
    
    func loginSuccess(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setTabbarControllerAsRoot()
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Ooops!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
