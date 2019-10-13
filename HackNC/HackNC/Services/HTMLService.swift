//
//  HTMLService.swift
//  HackNC
//
//  Created by Max Nabokow on 10/13/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import Foundation
import SwiftSoup

public class HTMLService {
    
    private init() {}
    static let shared = HTMLService()
    
    private let defaults: UserDefaults = .shared
    
    func hasRecentPost() -> Bool {
        return defaults.object(forKey: "recentUrl") != nil
    }
    
    func parseRecentPost() -> Article? {
        
        var title: String?
        var description: String?
        var pubDate: String?
        var source: String?
        
        guard let url = defaults.object(forKey: "recentUrl") as? String else { return nil }
        
        if let html = defaults.object(forKey: "recentUrlHTML") as? String {
            
            do {
                let doc = try SwiftSoup.parse(html)
                
                if let element = try doc.select("meta[property=og:site_name]").first() {
                    source = try element.attr("content")
                }
                
                if let element = try doc.select("meta[property=og:pubdate]").first() {
                    pubDate = try element.attr("content")
                }
//
//                if let h1 = try doc.select("h1").first() {
//                    title = try h1.text()
//                }
                
                if let element = try doc.select("meta[property=og:title]").first() {
                    title = try element.attr("content")
                }
                
                if let element = try doc.select("meta[property=og:description]").first() {
                    description = try element.attr("content")
                }
                
            } catch {
                print("Error parsing HTML: \(error.localizedDescription)")
            }
        }
        
        let article = Article(id: UUID().uuidString, title: title, description: description, timeStamp: pubDate, source: source, url: url)
        
        return article
    }
}
