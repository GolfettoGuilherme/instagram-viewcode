//
//  ViewController.swift
//  Instagram
//
//  Created by Guilherme Golfetto on 06/09/21.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       handleNotAutheticated()
    }

    private func handleNotAutheticated() {
        // check auth status
        if Auth.auth().currentUser != nil {
            //show log in
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            
            present(loginVc, animated: false)
        }
    }

}

