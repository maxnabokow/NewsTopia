//
//  ViewController.swift
//  HackNC
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import UIKit
import SwiftSoup

class DashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var articles: [Article?] = []
    
    let table: UITableView = {
        let t = UITableView()
        t.separatorStyle = .none
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        HTMLService.shared.parseRecentPost()
        
        title = "Feed"
        
        table.delegate = self
        table.dataSource = self
        
        setupLayout()
        
        FirestoreService.shared.fetchArticles { (articles) in
            self.articles = articles
            self.table.reloadData()
        }
    }
    
    fileprivate func setupLayout() {
        view.addSubview(table)
        table.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FeedCell()
        guard let article = articles[indexPath.row] else { return cell }
        cell.speechBubble.configure(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
