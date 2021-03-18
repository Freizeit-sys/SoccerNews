//
//  FeedDetailController.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/17.
//

import UIKit


class FeedDetailController: UIViewController {
    
    var feed: Article?
    
    private let v = FeedDetailView()
    
    override func loadView() {
        self.view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}
