//
//  CustomImageView.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/18.
//

import UIKit

var imageCache: [String: UIImage] = [:]

class CustomImageView: UIImageView {
    
    var lastURLUsedLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedLoadImage = urlString
        
        self.image = nil
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch feed image:", error)
                return
            }
            
            if url.absoluteString != self.lastURLUsedLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let image = UIImage(data: imageData)
            imageCache[url.absoluteString] = image
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
