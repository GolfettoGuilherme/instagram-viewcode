//
//  AuthManager.swift
//  Instagram
//
//  Created by Guilherme Golfetto on 06/09/21.
//

import FirebaseAuth


public class AuthManager {
    
    static let shared = AuthManager() // ??
    
    //MARK: - Public
    
    public func registerNewUser(username:String, email: String, password: String, completion: @escaping(Bool) -> Void) {
        
        //check if username is avalive
        //check if email is avaliable
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            
            if canCreate{
                //create account
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    
                    guard error == nil, result != nil else {
                        //deu erro
                        completion(false)
                        return
                    }
                    
                    //insert account to databases
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else{
                            completion(false)
                            return
                        }
                    }
                    
                }
                
            } else{
                //não pode criar a conta
                completion(false)
            }
            
        }
        
    }
    
    //precisa usar o escaping porque usamos uma clojure dentro de outra clojure, então o contexto precisa escapar disso
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                
                completion(true)
            }
        }
        else if let username = username {
            print(username)
        }
    }

    
}
