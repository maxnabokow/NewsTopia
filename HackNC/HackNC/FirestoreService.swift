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
    let db = Firestore.firestore()
    
    func fetchArticles(completion: @escaping ([Article]) -> Void) {
        
        db.collection("articles").addSnapshotListener { (snapshot, err) in
            if err == nil {
                guard let documents = snapshot?.documents else { return }
                
                var articles = [Article]()
                
                for document in documents {

                    let id = document.documentID
                    let title = document["title"] as? String ?? ""
                    let summary = document["summary"] as? String ?? ""
                    let body = document["body"] as? String ?? ""
                    let authorId = document["authorId"] as? Int ?? -1
                    let source = document["source"] as? String ?? ""
                    let url = document["url"] as? String ?? ""
                    let hits = document["hits"] as? Int ?? 0
                    let tags = document["tags"] as? [String] ?? []
                    let timeStamp = document["timestamp"] as? String ?? ""
                    
                    let article = Article(id: id, title: title, summary: summary, body: body, timeStamp: timeStamp, authorId: authorId, source: source, url: url, hits: hits, tags: tags)
                    articles.append(article)
                    
                    completion(articles)
                }
            }
        }
    }
}
