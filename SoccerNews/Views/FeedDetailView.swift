//
//  FeedDetailView.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/18.
//

import UIKit

protocol FeedDetailViewDelegate: class {
    func didShowPreviewImage(_ image: UIImage)
}

class FeedDetailView: UIView {
    
    weak var delegate: FeedDetailViewDelegate?
    
    var feed: Article? {
        didSet {
            guard let feed = self.feed else { return }
            feedTitleLabel.text = feed.title
            feedAuthorLabel.text = feed.author ?? "Unknown"
            
            if let domain = feed.source?.name {
                guard let url = URL(string: "https://www.google.com/s2/favicons?domain=\(domain)") else { return }
                feedFaviconImageView.loadImage(urlString: url.absoluteString)
                feedSorceNameLabel.text = domain.components(separatedBy: ".").first ?? domain
            }
            
            if let publishedAt = feed.publishedAt {
                feedTimeAgoLabel.text = convertDateStringToTimeAgo(publishedAt)
            }
            
            if let urlString = feed.urlToImage {
                feedImageView.loadImage(urlString: urlString)
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10.0
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: paragraphStyle
            ]
            
            let attributedText = NSMutableAttributedString(string: feed.description ?? "", attributes: attributes)
            feedDescriptionLabel.attributedText = attributedText
        }
    }
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.automaticallyAdjustsScrollIndicatorInsets = false
        return sv
    }()
    
    private let feedTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.scheme.label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = .max
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let feedFaviconImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 36 / 2
        return iv
    }()
    
    private let feedSorceNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.scheme.label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let feedAuthorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.scheme.secondaryLabel
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private let feedTimeAgoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.scheme.secondaryLabel
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private let feedImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let feedDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.scheme.label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        return tap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(scrollView)
        
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubview(feedTitleLabel)
        scrollView.addSubview(feedFaviconImageView)
        scrollView.addSubview(feedSorceNameLabel)
        scrollView.addSubview(feedAuthorLabel)
        scrollView.addSubview(feedTimeAgoLabel)
        scrollView.addSubview(feedImageView)
        scrollView.addSubview(feedDescriptionLabel)
        
        feedImageView.addGestureRecognizer(tapGesture)
        
        tapGesture.addTarget(self, action: #selector(handleTapGesture))
        
        feedTitleLabel.anchor(top: scrollView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        feedFaviconImageView.anchor(top: feedTitleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        
        feedSorceNameLabel.anchor(top: nil, left: feedFaviconImageView.rightAnchor, bottom: feedFaviconImageView.centerYAnchor, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 1, paddingRight: 0, width: 0, height: 0)
        
        feedAuthorLabel.anchor(top: feedFaviconImageView.centerYAnchor, left: feedFaviconImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 1, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        feedTimeAgoLabel.anchor(top: feedAuthorLabel.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        feedImageView.anchor(top: feedTimeAgoLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        
        feedDescriptionLabel.anchor(top: feedImageView.bottomAnchor, left: leftAnchor, bottom: scrollView.bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
    
    private func convertDateStringToTimeAgo(_ dateString: String) -> String {
        let formatter = DateFormatter()
        // GET => api field = publishedAt: 2021-03-09T19:00:00Z
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        
        guard let date = formatter.date(from: dateString) else { return "Failed to convert date." }
        return date.timeAgo()
    }
    
    @objc private func handleTapGesture() {
        guard let selectedImage = feedImageView.image else { return }
        delegate?.didShowPreviewImage(selectedImage)
    }
}
