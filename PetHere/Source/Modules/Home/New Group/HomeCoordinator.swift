//
//  HomeCoordinator.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 04/04/21.
//

import UIKit
import Firebase

class HomeCoordinator: PushedCoordinate {
    
    var nextCoordinator: Coordinator?
    var presenting: UINavigationController
    
    private let user: User
    
    init(presenting: UINavigationController,
         user: User) {
        self.user = user
        self.presenting = presenting
    }
    
    func loadInitialModule() -> UIViewController {
        let viewModel = HomeViewModel(user: user,
                                      coordinator: self)
        return HomeViewController(viewModel: viewModel)
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {

    func startPets() {
        
    }
    
    func showProfile() {
        
    }
    
    func showScan() {
        
    }
}
