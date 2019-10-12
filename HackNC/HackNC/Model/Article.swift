//
//  Article.swift
//  HackNC
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import Foundation

struct Article: Decodable {
    var id: String
    
    var title: String
    var summary: String
    var body: String
    
    var timeStamp: String
    var authorId: Int
    var source: String
    var url: String
    
    var hits: Int
    var tags: [String?]
}
