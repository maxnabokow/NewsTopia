//
//  Article.swift
//  HackNC
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import Foundation

struct Article {
    var id: Int
    
    var title: String
    var summary: String
    var body: String
    
    var timeStamp: Date
    var authorId: Int
    
    var hits: Int
    var tags: [String]
}
