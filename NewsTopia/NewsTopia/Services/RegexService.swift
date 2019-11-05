//
//  RegexService.swift
//  HackNC
//
//  Created by Max Nabokow on 10/13/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import Foundation

class RegexService {
    private init() {}
    static let shared = RegexService()
    
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func check(for regex: String, in text: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let range = NSRange(location: 0, length: text.utf16.count)
            
            guard let result = regex.firstMatch(in: text, options: [], range: range) else { return nil }

            return String(text[Range(result.range, in: text)!])
        } catch { }
        
        return nil
    }
}
