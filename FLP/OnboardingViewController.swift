//
//  LoginViewController.swift
//  FLP
//
//  Created by Bob De Kort on 3/14/17.
//  Copyright © 2017 Bob De Kort. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollview: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor.projectColor()
        sv.isPagingEnabled = true
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    let pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 2
        pc.currentPage = 0
        pc.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        return pc
    }()
    
    var myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        addScrollView()
        scrollview.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        
        let V1: Onboard1 = Onboard1(nibName: "Onboard1", bundle: nil)
        let V2: Onboard2 = Onboard2(nibName: "Onboard2", bundle: nil)
        
        V2.loginParent = self
        
        self.addChildViewController(V1)
        self.scrollview.addSubview(V1.view)
        V1.didMove(toParentViewController: self)
        
        self.addChildViewController(V2)
        self.scrollview.addSubview(V2.view)
        V2.didMove(toParentViewController: self)
        
        var V2Frame: CGRect = V2.view.frame
        V2Frame.origin.x = self.view.frame.width
        V2.view.frame = V2Frame
        
        self.scrollview.contentSize = CGSize(width: self.view.frame.width * 2, height: self.view.frame.height - 20)
        
        addPageControl()
        
        myActivityIndicator.center = view.center
    }
    
    func addPageControl(){
        view.addSubview(pageControl)
        
        view.addConstraintsWithFormat("V:[v0]-20-|", views: pageControl)
        view.addConstraintsWithFormat("H:|[v0]|", views: pageControl)
        
    }
    
    func pageChanged(){
        let x = CGFloat(pageControl.currentPage) * scrollview.frame.size.width
        scrollview.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    func scrollToLogin(){
        scrollview.scrollRectToVisible(CGRect(x: self.view.frame.origin.x * 2, y: self.view.frame.origin.y, width: 1, height: 1), animated: true)
    }
    
    func startAnimatingActivityMonitor(){
        view.addSubview(myActivityIndicator)
        myActivityIndicator.startAnimating()
    }
    
    func didLogin(){
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
    }
    
    func addScrollView(){
        view.addSubview(scrollview)
        
        view.addConstraintsWithFormat("V:|[v0]|", views: scrollview)
        view.addConstraintsWithFormat("H:|[v0]|", views: scrollview)
    }
}
