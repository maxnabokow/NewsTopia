//
//  CreateArticleVC.swift
//  HackNC
//
//  Created by Max Nabokow on 10/13/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import UIKit
import LBTATools
import FirebaseAuth

class CreateArticleVC: UIViewController {
    
    var article: Article! {
        didSet {
            titleLabel.text = article.title
            sourceLabel.text = article.source
        }
    }
    
    let titleLabel: UILabel = {
        let l = UILabel(text: "", font: .systemFont(ofSize: 22, weight: .semibold), textAlignment: .left, numberOfLines: 0)
        l.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return l
    }()
    
    let sourceLabel: UILabel = {
        let l = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .regular), textAlignment: .left, numberOfLines: 1)
        l.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return l
    }()
    
    let rateThisArticleLabel: UILabel = {
        let l = UILabel(text: "Rate this article: 0", font: .systemFont(ofSize: 14, weight: .regular), textAlignment: .left, numberOfLines: 1)
        l.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return l
    }()
    
    let ratingSlider: UISlider = {
        let s = UISlider()
        s.minimumValue = 0
        s.maximumValue = 10
        s.thumbTintColor = .white
        s.minimumTrackTintColor = .blue
        s.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return s
    }()
    
    let commentTextView: UITextView = {
        let v = UITextView(text: "Add a comment…")
        v.backgroundColor = .lightGray
        v.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        v.setupShadow(opacity: 0.3, radius: 12, offset: .init(width: 6, height: 6), color: .black)
        return v
    }()
    
    let cancelButton: UIButton = {
        let b = UIButton(title: "CANCEL", titleColor: .white, font: .systemFont(ofSize: 20, weight: .semibold), backgroundColor: .darkGray, target: self, action: #selector(cancelTapped))
        b.layer.cornerRadius = 8
        return b
    }()
    
    let sendButton: UIButton = {
        let b = UIButton(title: "SEND", titleColor: .white, font: .systemFont(ofSize: 20, weight: .bold), backgroundColor: .cyan, target: self, action: #selector(sendTapped))
        b.layer.cornerRadius = 8
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
    }
    
    func configure(article: Article) {
        self.article = article
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sliderValueChanged() {
        rateThisArticleLabel.text = "Rate this article: \(Int(ratingSlider.value))"
    }
    
    @objc func sendTapped() {
        FirestoreService.shared.isUnique(article) { (unique) in
            if unique {
                FirestoreService.shared.createArticle(self.article)
            }
            
            let review = Review(user_id: Auth.auth().currentUser?.uid ?? "", comment: self.commentTextView.text, rating: Int(self.ratingSlider.value))
            FirestoreService.shared.createReview(for: self.article, review: review)
        }
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(sourceLabel)
        view.addSubview(rateThisArticleLabel)
        view.addSubview(ratingSlider)
        view.addSubview(commentTextView)
        
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, sendButton])
        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 24
        view.addSubview(buttonStackView)
        
        titleLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 24, bottom: 0, right: 24))
        sourceLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 24, bottom: 0, right: 24))
        
        rateThisArticleLabel.anchor(top: sourceLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 60, left: 24, bottom: 0, right: 24))
        ratingSlider.anchor(top: rateThisArticleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 24, bottom: 0, right: 24))
        ratingSlider.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        commentTextView.anchor(top: ratingSlider.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 24, bottom: 0, right: 24))
        commentTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        buttonStackView.anchor(top: commentTextView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 40, left: 24, bottom: 24, right: 40))
    }
}
