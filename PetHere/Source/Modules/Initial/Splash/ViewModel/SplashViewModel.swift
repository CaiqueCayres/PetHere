//
//  SplashViewModel.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 04/04/21.
//

import Foundation

class SplashViewModel {
    
    private let coordinator: MainCoordinatorProtocol
    private var view: SplashViewProtocol?
    
    let animationHandler: () -> Void
    
    init(coordinator: MainCoordinatorProtocol,
         animationHandler: @escaping () -> Void) {
        self.animationHandler = animationHandler
        self.coordinator = coordinator
    }
    
    func executeAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.animationHandler()
        }
    }
}

extension SplashViewModel: SplashViewModelProtocol {
    
}
