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
                    
                    let totalRating = document["totalRating"] as? Int ?? 0
                    let numReviews = document["numReviews"] as? Int ?? 0
                    
                    let article = Article(id: id, title: title, description: description, source: source, url: url, totalRating: totalRating, numReviews: numReviews)
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
            "numReviews" : 0
        ])
    }
    
    func createReview(for article: Article, review: Review) {
        guard
            let articleTitle = article.title,
            let articleSource = article.source
            else { return }
        
        // create review document
        articles.document(articleTitle + articleSource).collection("Reviews").addDocument(data: [
            "userId" : Auth.auth().currentUser?.uid ?? "",
            "comment" : review.comment ?? "",
            "rating" : review.rating
        ])
        
        // update article document
        articles.document(articleTitle + articleSource).updateData([
//            "title" : articleTitle,
//            "description" : article.description ?? "",
//            "source" : articleSource,
//            "url" : article.url ?? "",
//            "timestamp" : article.timeStamp ?? "",
            "totalRating" : FieldValue.increment(Int64(review.rating)),
            "numReviews" : FieldValue.increment(Int64(1))
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
