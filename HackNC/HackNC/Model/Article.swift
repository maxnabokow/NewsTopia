//
//  Article.swift
//  HackNC
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import Foundation

struct Article: Decodable {
    var id: String?
    
    var title: String?
    var description: String?
    
    var timeStamp: String?
    var source: String?
    var url: String?
}
