//
//  LoginVC.swift
//  HackNC
//
//  Created by Max Nabokow on 10/13/19.
//  Copyright © 2019 Maximilian Nabokow. All rights reserved.
//

import UIKit
import FirebaseAuth
import LBTATools
import JGProgressHUD


class LoginVC: UIViewController {
    
    let emailTextField: UITextField = {
        let tf = UITextField(placeholder: "Email")
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField(placeholder: "Password")
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let loginButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .red
        b.setTitle("Log in", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        b.layer.cornerRadius = 24
        b.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return b
    }()
    
    let signUpButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .gray
        b.setTitle("No account? Sign up.", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 24
        b.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isModalInPresentation = true
        view.backgroundColor = .white

        setupLayout()
        
    }
    
    @objc func loginTapped() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Logging in"
        hud.show(in: self.view)
        
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (_, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                hud.dismiss()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func signUpTapped() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Signing you up"
        hud.show(in: self.view)
        
        Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (authResult, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                hud.dismiss()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func setupLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        emailTextField.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 24, bottom: 0, right: 24))
        emailTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 24, bottom: 0, right: 24))
        passwordTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true

        loginButton.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 24, bottom: 0, right: 24))
        loginButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        signUpButton.anchor(top: loginButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 24, bottom: 0, right: 24))
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
