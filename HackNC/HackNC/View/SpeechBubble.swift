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
    
    var article: Article!
    
    let titleLabel: UILabel = {
        let l = UILabel(text: "", font: .boldSystemFont(ofSize: 20), textAlignment: .left, numberOfLines: 2)
        l.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return l
    }()
    
    let sourceLabel: UILabel = {
        let l = UILabel(text: "", font: .systemFont(ofSize: 16), textAlignment: .left, numberOfLines: 1)
        l.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return l
    }()
    
    let descriptionLabel: UILabel = {
        let l = UILabel(text: "", font: .systemFont(ofSize: 14), textAlignment: .left, numberOfLines: 3)
        l.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return l
    }()

    let gradientView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 9
        v.layer.borderColor = UIColor.darkGray.cgColor
        v.layer.borderWidth = 0.6
        v.setupShadow(opacity: 0.3, radius: 6, offset: .init(width: 3, height: 3), color: .black)
        return v
    }()
    
    let trustLabel: UILabel = {
        let l = UILabel(text: "", font: .systemFont(ofSize: 20, weight: .semibold), textAlignment: .right, numberOfLines: 1)
        l.textColor = .darkGray
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        layer.cornerRadius = 24
        setupShadow(opacity: 0.5, radius: 6, offset: .init(width: 3, height: 3), color: .white)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(article: Article) {
        self.article = article
        
        titleLabel.text = article.title
        sourceLabel.text = article.source ?? ""
        descriptionLabel.text = article.description
        
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maxLength = frame.width - 48

        let avgRating = CGFloat(article.totalRating) / CGFloat(article.numReviews)
        trustLabel.text = "\(Int(avgRating))/10"
        let multiplier: CGFloat = avgRating / 10.0
        
        switch avgRating {
        case 0: gradientView.backgroundColor = .red
        case 1: gradientView.backgroundColor = .red
        case 2: gradientView.backgroundColor = .red
        case 3: gradientView.backgroundColor = .red
        case 4: gradientView.backgroundColor = .yellow
        case 5: gradientView.backgroundColor = .yellow
        case 6: gradientView.backgroundColor = .yellow
        case 7: gradientView.backgroundColor = .yellow
        case 8: gradientView.backgroundColor = .green
        case 9: gradientView.backgroundColor = .green
        default: gradientView.backgroundColor = .green
        }
        
        let cgfloatWidth = maxLength * multiplier
        
        gradientView.widthAnchor.constraint(equalToConstant: cgfloatWidth).isActive = true
    }
    
    fileprivate func setupLayout() {
        addSubview(titleLabel)
        addSubview(sourceLabel)
        addSubview(descriptionLabel)
        addSubview(gradientView)
        addSubview(trustLabel)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 24, bottom: 0, right: 24))
        
        sourceLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 24, bottom: 0, right: 24))
        
        descriptionLabel.anchor(top: sourceLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 24, bottom: 0, right: 24))
        
        gradientView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 40, right: 0))
        
        
        gradientView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        trustLabel.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 6, right: 24))
    }
}
