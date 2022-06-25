//
//  AccountManager.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 30/03/21.
//

import FirebaseAuth

enum AuthStatus {
    
    case auth(User)
}

enum AuthError: Swift.Error {
    
    case FIRError(Error)
    case unknow
}

protocol AccountManagerProtocol {
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<AuthStatus,
                                              AuthError>) -> Void)
    func auth(completion: @escaping (Result<AuthStatus,AuthError>) -> Void)
}

class AccountManager: NSObject {
    
    let firAuth: Auth
    
    var currentUser: User? { Auth.auth().currentUser }
    
    init(firAuth: Auth = Auth.auth()) {
        self.firAuth = firAuth
        super.init()
    }
}
extension AccountManager: AccountManagerProtocol {
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<AuthStatus, AuthError>) -> Void) {
        
    }
    
    func auth(completion: @escaping (Result<AuthStatus,AuthError>) -> Void) {
        self.firAuth.signInAnonymously { (result, error) in
            
            if let error = error {
                completion(.failure(.FIRError(error)))
            }
            
            guard let result = result else {
                completion(.failure(.unknow))
                return
            }
            
            completion(.success(.auth(result.user)))
        }
    }
}
