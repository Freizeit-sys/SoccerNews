//
//  MainNavigationController.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/18.
//

import UIKit
import AMScrollingNavbar

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationBar.barTintColor = UIColor.scheme.background
        navigationBar.isTranslucent = false
    }
    
    public func navigationBarRemoveSeparator() {
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
