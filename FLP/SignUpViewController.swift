//
//  SignUpViewController.swift
//  FLP
//
//  Created by Bob De Kort on 4/20/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func signUpPressed(_ sender: Any) {
        guard let username = usernameTextField.text else {
            presentAlert(message: "Please fill in a username")
            return
        }
        
        guard let password = passwordTextField.text else {
            presentAlert(message: "Please fill in a password")
            return
        }
        
        guard let confirmedPassword = confirmPasswordTextField.text else {
            presentAlert(message: "Please confirm your password")
            return
        }
        
        guard let email = emailTextField.text else {
            presentAlert(message: "Please fill in your email address")
            return
        }
        
        guard password == confirmedPassword else {
            presentAlert(message: "Passwords do not match.")
            return
        }
        
        // TODO: Sign up
        ApiService.sharedInstance.signUp(email: email, password: password, username: username) { (result) in
            if result {
                self.signUpSucces()
            } else {
                self.presentAlert(message: "Something went wrong please try again")
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupButton()
    }
    
    func setupButton(){
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor.projectColor().cgColor
        signupButton.layer.cornerRadius = signupButton.frame.height/4
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.backgroundColor = UIColor.projectColor()
    }
    
    func setupTextFields(){
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.projectColor().cgColor
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 4
        
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.projectColor().cgColor
        usernameTextField.layer.cornerRadius = usernameTextField.frame.height / 4
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.projectColor().cgColor
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 4
        
        confirmPasswordTextField.layer.borderWidth = 1
        confirmPasswordTextField.layer.borderColor = UIColor.projectColor().cgColor
        confirmPasswordTextField.layer.cornerRadius = confirmPasswordTextField.frame.height / 4
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Ooops!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func signUpSucces(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setTabbarControllerAsRoot()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
