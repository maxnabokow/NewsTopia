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
    
    func fetchArticles() {
        db.collection("articles").document("Io13YaSFqoTeKbcyGmgQ").collection("reviews").getDocuments { (snapshot, err) in
            
            guard let id = snapshot?.documents[0].data()["user_id"] as? String else { return }
            
            print(id)
        }
        
    }
}
