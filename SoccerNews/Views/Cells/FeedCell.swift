//
//  FeedCell.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/16.
//

import UIKit

class FeedCell: UITableViewCell {
    
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    private let feedFaviconImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 18 / 2
        return iv
    }()
    
    private let feedSorceNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private let feedTimeAgoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        feedImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 120, height: 100)
        feedImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            feedTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            feedTitleLabel.leftAnchor.constraint(equalTo: feedImageView.rightAnchor, constant: 16),
            feedTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            feedTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: feedTimeAgoLabel.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            feedFaviconImageView.topAnchor.constraint(greaterThanOrEqualTo: feedTitleLabel.bottomAnchor),
            feedFaviconImageView.leftAnchor.constraint(equalTo: feedImageView.rightAnchor, constant: 16),
            feedFaviconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            feedFaviconImageView.widthAnchor.constraint(equalToConstant: 18),
            feedFaviconImageView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            feedSorceNameLabel.topAnchor.constraint(greaterThanOrEqualTo: feedTitleLabel.bottomAnchor),
            feedSorceNameLabel.leftAnchor.constraint(equalTo: feedFaviconImageView.rightAnchor, constant: 10),
            feedSorceNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            feedTimeAgoLabel.topAnchor.constraint(greaterThanOrEqualTo: feedTitleLabel.bottomAnchor),
            feedTimeAgoLabel.leftAnchor.constraint(greaterThanOrEqualTo: feedSorceNameLabel.rightAnchor, constant: 16),
            feedTimeAgoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            feedTimeAgoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func convertDateStringToTimeAgo(_ dateString: String) -> String {
        let formatter = DateFormatter()
        // GET => api field = publishedAt: 2021-03-09T19:00:00Z
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        
        guard let date = formatter.date(from: dateString) else { return "Failed to convert date." }
        return date.timeAgo()
    }
}
