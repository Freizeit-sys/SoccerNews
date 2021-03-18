//
//  FeedsView.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/18.
//

import UIKit

class FeedsView: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = UIColor.lightGray
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    public let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.secondarySystemBackground
        tv.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 16))
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
        addSubview(spinner)
        addSubview(tableView)
        
        spinner.centerInSuperView()
        tableView.fillSuperView()
    }
    
    public func showSpinner() {
        tableView.alpha = 0.0
        spinner.startAnimating()
    }
    
    public func hideSpinner() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear) {
            self.tableView.alpha = 1.0
        } completion: { (finished) in
            self.spinner.stopAnimating()
        }

    }
}
