//
//  HomeViewModel.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 04/04/21.
//

import Firebase

class HomeViewModel {
    
    let user: User
    
    let coordinator: HomeCoordinatorProtocol

    init(user: User,
         coordinator: HomeCoordinatorProtocol) {
        self.user = user
        self.coordinator = coordinator
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
}
