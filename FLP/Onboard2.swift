//
//  Login2.swift
//  FLP
//
//  Created by Bob De Kort on 3/14/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class Onboard2: UIViewController {
    
    let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        return btn
    }()
    
    let signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("signup", for: .normal)
        return btn
    }()
    
    var loginParent: OnboardingViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(loginButton)
        self.view.addSubview(signUpButton)
        
        view.addConstraintsWithFormat("V:|-200-[v0]", views: loginButton)
        view.addConstraintsWithFormat("V:|-200-[v0]", views: signUpButton)
        
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: self.view.frame.width/4))
        
        view.addConstraint(NSLayoutConstraint(item: signUpButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: (self.view.frame.width/4)*3))
        
        view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 200))
        
        view.addConstraint(NSLayoutConstraint(item: signUpButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 200))
        
        self.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login(){
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func signUp(){
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
