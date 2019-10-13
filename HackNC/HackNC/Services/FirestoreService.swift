//
//  FirestoreService.swift
//  HackNC
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
    
    private init() {}
    static let shared = FirestoreService()
    
    let articles = Firestore.firestore().collection("articles")

    func fetchArticles(completion: @escaping ([Article]) -> Void) {
        
        articles.addSnapshotListener { (snapshot, err) in
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
    
    func createArticle(_ article: Article) {
        
        guard
            let articleTitle = article.title,
            let articleSource = article.source
            else { return }
        
        
        articles.document(articleTitle + articleSource).setData([
            "title" : article.title ?? "",
            "description" : article.description ?? "",
            "source" : article.source ?? "",
            "url" : article.url ?? "",
            "timestamp" : article.timeStamp ?? ""
            ])
    }
    
    func createReview(for article: Article, review: Review) {
        guard
            let articleTitle = article.title,
            let articleSource = article.source
            else { return }
        
        articles.document(articleTitle + articleSource).collection("Reviews").addDocument(data: [
            "userId" : Auth.auth().currentUser?.uid ?? "",
            "comment" : review.comment ?? "",
            "rating" : review.rating
            ])
        let currentRating = article.totalRating
        
        articles.document(articleTitle + articleSource).setData([
            "title" : article.title ?? "",
            "description" : article.description ?? "",
            "source" : article.source ?? "",
            "url" : article.url ?? "",
            "timestamp" : article.timeStamp ?? "",
            "totalRating" : (currentRating + review.rating)
        ])
        
    }
    
    func isUnique(_ article: Article, completion: @escaping (Bool) -> Void) {

        if let articleTitle = article.title,
            let articleSource = article.source {
            
            print(articles.document(articleTitle + articleSource))
            
            let query = articles.whereField("title", isEqualTo: articleTitle).whereField("source", isEqualTo: articleSource)
            
            query.getDocuments { (snapshot, err) in
                guard let snapshot = snapshot else { return }
                print(snapshot.documents.count)
                if snapshot.documents.count == 0 {
                    completion(true)
                }
            }
            completion(false)
        }
    }
}
