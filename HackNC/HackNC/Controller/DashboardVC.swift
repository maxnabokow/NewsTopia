//
//  ViewController.swift
//  HackNC
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let table: UITableView = {
        let t = UITableView()
        t.separatorStyle = .none
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Feed"
        table.delegate = self
        table.dataSource = self
        
        setupLayout()
        
        FirestoreService.shared.fetchArticles()
    }
    
    fileprivate func setupLayout() {
        view.addSubview(table)
        table.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return FeedCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
