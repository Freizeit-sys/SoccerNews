//
//  TopFeedCell.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/18.
//

import UIKit

class TopFeedCell: UITableViewCell {
    
    var article: Article? {
        didSet {
            guard let article = self.article else { return }
            
            if let urlString = article.urlToImage {
                feedImageView.loadImage(urlString: urlString)
            }
            
            feedTitleLabel.text = article.title
            
            if let publishedAt = article.publishedAt {
                feedTimeAgoLabel.text = convertDateStringToTimeAgo(publishedAt)
            }
            
            if let domain = article.source?.name {
                guard let url = URL(string: "https://www.google.com/s2/favicons?domain=\(domain)") else { return }
                feedFaviconImageView.loadImage(urlString: url.absoluteString)
                feedSorceNameLabel.text = domain.components(separatedBy: ".").first ?? domain
            }
        }
    }
    
    private let feedImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 4
        return iv
    }()
    
    private let feedTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    private let feedFaviconImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 18 / 2
        return iv
    }()
    
    private let feedSorceNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private let feedTimeAgoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(feedImageView)
        addSubview(feedTitleLabel)
        addSubview(feedFaviconImageView)
        addSubview(feedSorceNameLabel)
        addSubview(feedTimeAgoLabel)
        
        feedImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 200)
        
        feedTitleLabel.anchor(top: feedImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        feedFaviconImageView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 16, paddingRight: 0, width: 18, height: 18)
        
        feedSorceNameLabel.anchor(top: nil, left: feedFaviconImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 16, paddingRight: 0, width: 0, height: 0)
        
        feedTimeAgoLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 16, paddingRight: 16, width: 0, height: 0)
        // TODO: - constant = feedTimeAgoLabel.paddingBottom + feedTitleLabel distance(48)
        feedTimeAgoLabel.topAnchor.constraint(lessThanOrEqualTo: feedTitleLabel.bottomAnchor, constant: 56).isActive = true
    }
    
    private func convertDateStringToTimeAgo(_ dateString: String) -> String {
        let formatter = DateFormatter()
        // GET => api field = publishedAt: 2021-03-09T19:00:00Z
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        
        guard let date = formatter.date(from: dateString) else { return "Failed to convert date." }
        return date.timeAgo()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.removeSectionSeparators()
    }
    
    private func removeSectionSeparators() {
        for subview in subviews {
            if subview != contentView && subview.frame.width == frame.width && subview.frame.height == 0.5 {
                subview.removeFromSuperview()
            }
        }
    }
}
