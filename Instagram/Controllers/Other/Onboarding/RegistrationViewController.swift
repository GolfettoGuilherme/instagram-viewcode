//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Guilherme Golfetto on 06/09/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Contants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next //para ir para o proximo elemento quando apertar no enter
        field.leftViewMode = .always // ??
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // ??
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Contants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.returnKeyType = .next //para ir para o proximo elemento quando apertar no enter
        field.leftViewMode = .always // ??
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // ??
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Contants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue //para ir para o proximo elemento quando apertar no enter
        field.leftViewMode = .always // ??
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) // ??
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Contants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Contants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        userNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self

        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //primeiro que aparece, o Y dele ?? o topo da tela + 10 de margin
        //width dele ?? o total da pagina - 40 de margin
        userNameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: view.width - 40, height: 52)
        
        //o Y dele ?? o final do componente anterior + 10 de margin
        emailField.frame = CGRect(x: 20, y: userNameField.bottom + 10, width: view.width - 40, height: 52)
        
        //o Y dele ?? o final do componente anterior + 10 de margin
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40, height: 52)
        
        //o Y dele ?? o final do componente anterior + 10 de margin
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width - 40, height: 52)
    }
    
    @objc private func didTapRegister() {
        emailField.resignFirstResponder()
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let username = userNameField.text,!username.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    //deu bom
                } else{
                    //failed
                }
            }

        }
        
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField{
            passwordField.becomeFirstResponder()
        } else{
            didTapRegister()
        }
        
        return true
    }
}
