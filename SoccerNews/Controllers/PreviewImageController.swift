//
//  PreviewImageController.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/19.
//

import UIKit

class PreviewImageController: UIViewController {
    
    var previewImage: UIImage?
    
    private let v = PreviewImageView()
    
    override func loadView() {
        self.view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.v.previewImage = self.previewImage
        self.v.delegate = self
    }
}

extension PreviewImageController: PreviewImageViewDelegate {
    
    func didClose(_ animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}
