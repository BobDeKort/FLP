//
//  LeaveReviewViewController.swift
//  FLP
//
//  Created by Bob De Kort on 4/19/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit
import Cosmos

class LeaveReviewViewController: UIViewController, UITextViewDelegate {
    
    let ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.fillMode = .half
        view.settings.totalStars = 5
        view.settings.starSize = 25
        view.settings.starMargin = 5
        view.settings.filledColor = UIColor.projectColor()
        view.settings.emptyBorderColor = UIColor.projectColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separatorLine1: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Title"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let separatorLine2: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Your review here"
        tv.textColor = UIColor.lightGray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var tourId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Write a review"
        contentTextView.delegate = self
        
        setupNavBar()
        setupViews()
    }
    
    func setupViews(){
        self.view.addSubview(ratingView)
        self.view.addSubview(separatorLine1)
        self.view.addSubview(titleTextField)
        self.view.addSubview(separatorLine2)
        self.view.addSubview(contentTextView)
        
        let navbarHeight = (navigationController?.navigationBar.frame.height)! + 20
        
        ratingView.topAnchor.constraint(equalTo: self.view.topAnchor , constant: navbarHeight + 20).isActive = true
        ratingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: (self.view.frame.width)/3).isActive = true
        
        separatorLine1.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 10).isActive = true
        separatorLine1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        separatorLine1.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        separatorLine1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        separatorLine1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        titleTextField.topAnchor.constraint(equalTo: separatorLine1.bottomAnchor, constant: 10).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        titleTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        separatorLine2.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10).isActive = true
        separatorLine2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        separatorLine2.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        separatorLine2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        separatorLine2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        contentTextView.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor, constant: 10).isActive = true
        contentTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        contentTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        contentTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        contentTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setupNavBar(){
        // Cancel Button
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        
        self.navigationItem.leftBarButtonItem = cancelButton
        
        // Send Review button
        let sendButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(sendReview))
        
        self.navigationItem.rightBarButtonItem = sendButton
    }
    
    func checkFields() -> ReviewStruct? {
        if titleTextField.text != nil && titleTextField.text != "" {
            if contentTextView.text != nil && contentTextView.text != "" && contentTextView.text != "Your review here" {
                let title = titleTextField.text
                let content = contentTextView.text
                let rating = ratingView.rating
                
                return ReviewStruct(title: title!, content: content!, rating: rating)
            } else {
                print("fill in the review please")
                return nil
            }
        } else {
            print("Fill in the title please")
            return nil
        }
    }
    
    func sendReview(){
        if let review = checkFields() {
            if let tourId = tourId {
                ApiService.sharedInstance.postReview(tourId: tourId, review: review, completion: { (result) in
                    if result {
                        self.dismissView()
                    } else {
                        // TODO: Alert User
                        print("Something went wrong please try again")
                    }
                })
            }
        }
    }
    
    func dismissView(){
        navigationController?.popViewController(animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTextView.textColor == UIColor.lightGray {
            contentTextView.text = nil
            contentTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your review here"
            textView.textColor = UIColor.lightGray
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

struct ReviewStruct {
    var title: String
    var content: String
    var rating: Double
}
