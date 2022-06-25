//
//  UserManager.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 31/03/21.
//

import FirebaseAuth
import FirebaseFirestore

class UserManager: NSObject {
    
    private let db: Firestore
    
    let UID: String
    
    init(user: User) {
        self.db = Firestore.firestore()
        self.UID = user.uid
        super.init()
    }
    
    func saveCurrentUser() {

        db.collection("Users").document(UID).setData(["uid": UID,
                                                      "name": "Teste_name_1",
                                                      "birth": Date()]) { error in
            print(error as Any)
        }
    }
    
    func getCurrentUser() {
        
        db.collection("Users").document(UID).getDocument { (snap, error) in
            
                
        }
    }
}

extension UserManager {
    
    enum Error: Swift.Error {
        
        case noUser
        
    }
}
