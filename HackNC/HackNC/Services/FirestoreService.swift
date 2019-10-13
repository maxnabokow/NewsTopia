//
//  FirestoreService.swift
//  HackNC
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    
    private init() {}
    static let shared = FirestoreService()

    func fetchArticles(completion: @escaping ([Article]) -> Void) {
        
        Firestore.firestore().collection("articles").addSnapshotListener { (snapshot, err) in
            if err == nil {
                guard let documents = snapshot?.documents else { return }
                
                var articles = [Article]()
                
                for document in documents {

                    let id = document.documentID
                    let title = document["title"] as? String ?? ""
                    let description = document["description"] as? String ?? ""

                    let source = document["source"] as? String ?? ""
                    let url = document["url"] as? String ?? ""

                    let timeStamp = document["timestamp"] as? String ?? ""
                    
                    let article = Article(id: id, title: title, description: description, timeStamp: timeStamp, source: source, url: url)
                    articles.append(article)
                    
                    completion(articles)
                }
            }
        }
    }
}
