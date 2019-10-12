//
//  SpeechBubble.swift
//  HackNC
//
//  Created by Max Nabokow on 10/12/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import UIKit
import LBTATools

class SpeechBubble: UIView {
    
    var article: Article?
    
    let titleLabel: UILabel = {
        let l = UILabel(text: "", font: .boldSystemFont(ofSize: 20), textAlignment: .left, numberOfLines: 0)
        l.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return l
    }()
    
    let summaryLabel: UILabel = {
        let l = UILabel(text: "", font: .systemFont(ofSize: 14), textAlignment: .left, numberOfLines: 0)
        l.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return l
    }()
    
    let tagLabel: UILabel = {
        let l = UILabel(text: "#", font: .systemFont(ofSize: 16, weight: .semibold), textAlignment: .left, numberOfLines: 0)
        l.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return l
    }()
    
    let gradientView: GradientProgressView = {
        let v = GradientProgressView()
        
        v.gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor]
        v.layer.cornerRadius = 8
        
        return v
    }()
    
    let dateLabel: UILabel = {
        let l = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .semibold), textAlignment: .right, numberOfLines: 1)
        l.textColor = #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        layer.cornerRadius = 24
        setupShadow(opacity: 0.3, radius: 6, offset: .init(width: 4, height: 4), color: .black)
        
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(article: Article) {
        titleLabel.text = article.title
        summaryLabel.text = article.summary
        
        if !article.tags.isEmpty {
            var tagLabelString = "#"
                
            for (i,tag) in article.tags.enumerated() {
                if i > 0 {
                    tagLabelString += ","
                }
                if let tag = tag {
                    tagLabelString += " \(tag)"
                }
            }
            
            tagLabel.text = tagLabelString
        }
    }
    
    fileprivate func setupLayout() {
        addSubview(titleLabel)
        addSubview(summaryLabel)
        addSubview(tagLabel)
        addSubview(gradientView)
        addSubview(dateLabel)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 24, bottom: 0, right: 24))
        
        summaryLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 24, bottom: 0, right: 24))
        
        tagLabel.anchor(top: summaryLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 24, bottom: 0, right: 24))
        
        gradientView.anchor(top: tagLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 24, bottom: 0, right: 24))
        gradientView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        dateLabel.anchor(top: gradientView.bottomAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 12, right: 24))
    }
}
