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
        
        view.backgroundColor = UIColor.scheme.background
        
        self.v.feed = self.feed
        self.v.delegate = self
        
        self.setupNavigationItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}

extension FeedDetailController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension FeedDetailController {
    
    private func setupNavigationItems() {
        self.setupRemainingNavItems()
        self.setupLeftNavItem()
        self.setupRightNavItem()
    }
    
    // Remaining Navigation Items
    private func setupRemainingNavItems() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // Left Navigation Items
    private func setupLeftNavItem() {
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButton.tintColor = UIColor.scheme.button
        let image = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(image, for: .normal)
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // Right Navigation Items
    private func setupRightNavItem() {
        
    }
    
    @objc private func handleBack() {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension FeedDetailController: FeedDetailViewDelegate {
    
    func didShowPreviewImage(_ image: UIImage) {
        let previewimageVC = PreviewImageController()
        previewimageVC.previewImage = image
        previewimageVC.modalPresentationStyle = .overFullScreen
        present(previewimageVC, animated: true, completion: nil)
    }
}
