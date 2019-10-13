//
//  ViewController.swift
//  HackNC
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import SwiftSoup

class DashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var articles = [Article]()
    
    let table: UITableView = {
        let t = UITableView()
        t.separatorStyle = .none
        return t
    }()
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        if Auth.auth().currentUser == nil {
//            present(LoginVC(), animated: true)
//        } else {
//            if HTMLService.shared.hasRecentPost() {
//                if let newArticle = HTMLService.shared.parseRecentPost() {
//
//                    let createArticleVC = CreateArticleVC()
//                    createArticleVC.configure(article: newArticle)
//                    present(createArticleVC, animated: true)
//
//                    FirestoreService.shared.isUnique(newArticle, completion: { (unique) in
//                        if unique {
//                            FirestoreService.shared.create(newArticle)
//                        }
//                    })
//                }
//            }
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            present(LoginVC(), animated: true)
        } else {
            if HTMLService.shared.hasRecentPost() {
                if let newArticle = HTMLService.shared.parseRecentPost() {
                    
                    let createArticleVC = CreateArticleVC()
                    createArticleVC.configure(article: newArticle)
                    present(createArticleVC, animated: true)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = .init(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        fetchArticles()
        
        title = "Feed"
        
        table.delegate = self
        table.dataSource = self
        
        setupLayout()
    }
    
    @objc func logoutTapped() {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                present(LoginVC(), animated: true, completion: nil)
            } catch {
                print("Failed to log out: \(error.localizedDescription)")
            }
        }
    }
    
    fileprivate func fetchArticles() {
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
        cell.speechBubble.configure(article: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
