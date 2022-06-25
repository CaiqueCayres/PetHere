//
//  MainCoordinatorProtocol.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 04/04/21.
//

import Firebase

protocol MainCoordinatorProtocol {
 
    func startHome(for user: User)
    func showSplash()
    func showSignIn()
    func showLogin()
}
