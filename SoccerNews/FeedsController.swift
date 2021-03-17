//
//  FeedsController.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/16.
//

import UIKit

class FeedsView: UIView {
    
    public let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.tableFooterView = UIView(frame: .zero)
        tv.separatorStyle = .singleLine
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

class FeedsController: UIViewController {
    
    private var isFinishedPaging = false
    private var page = 0
    
    private var articles: [Article] = [];
    
    private let cellId = "cellId"
    private let v = FeedsView()
    
    override func loadView() {
        self.view = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.setupTableView()
        
        // Fetch news data
        //self.fetchNews()
        paginateFeeds()
    }
    
    // ニュースのデータを取得
    private func fetchNews() {
        NewsRepository.shared.fetchArticle { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.v.tableView.reloadData()
            }
        }
    }
    
    private func paginateFeeds() {
        page += 1
        let request = EverythingRequest(q: "Soccer", sources: [], domains: [], from: nil, to: nil, language: .JP, sortBy: .PublishedAt, page: page, pageSize: 5)
        NewsRepository.shared.fetchEverything(request) { (articles) in
            self.articles += articles
            
            if self.page >= 10 {
                self.isFinishedPaging = true
            }
            
            DispatchQueue.main.async {
                self.v.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        v.tableView.register(FeedCell.self, forCellReuseIdentifier: cellId)
        v.tableView.delegate = self
        v.tableView.dataSource = self
    }
}

extension FeedsController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // show you how to fire off the paginate cell
        if indexPath.row == articles.count - 1 && !isFinishedPaging {
            paginateFeeds()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FeedCell
        cell.article = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}
