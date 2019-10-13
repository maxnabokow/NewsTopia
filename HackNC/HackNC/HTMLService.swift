//
//  HTMLService.swift
//  HackNC
//
//  Created by Max Nabokow on 10/13/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import Foundation
import SwiftSoup

class HTMLService {
    
    private init() {}
    static let shared = HTMLService()
    
    private var defaults: UserDefaults = .shared
    
    func parseRecentPost() -> Article {
        
        var title: String?
        var description: String?
        var pubDate: String?
        var author: String?
        
        if let html = defaults.object(forKey: "recentUrlHTML") as? String {
            
            do {
                let doc = try SwiftSoup.parse(html)
                
                if let element = try doc.select("meta[property=og:pubdate]").first() {
                    pubDate = try element.attr("content")
                }
                
                if let element = try doc.select("meta[property=og:title]").first() {
                    title = try element.attr("content")
                }
                
                if let h1 = try doc.select("h1").first() {
                    title = try h1.text()
                }
                
                if let element = try doc.select("meta[property=og:description]").first() {
                    description = try element.attr("content")
                }
                
                if let element = try doc.select("meta[name=author]").first() {
                    author = try element.attr("content")
                }
            } catch {
                print("Error parsing HTML: \(error.localizedDescription)")
            }
        }
        
        let article = Article(id: UUID().uuidString, title: title, description: <#T##String#>, body: <#T##String#>, timeStamp: <#T##String#>, authorId: <#T##Int#>, source: <#T##String#>, url: <#T##String#>, hits: <#T##Int#>, tags: <#T##[String?]#>)
        
    }
}
