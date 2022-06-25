//
//  LoginViewModel.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 04/04/21.
//

import Foundation

class LoginViewModel {
    
    private let coordinator: MainCoordinatorProtocol
    var view: LoginViewProtocol?
    
    init(coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    
}
