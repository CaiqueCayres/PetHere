//
//  MainCoordinator.swift
//  CCoins
//
//  Created by Carlos Henrique Martins Cayres on 13/07/20.
//  Copyright © 2020 Carlos Henrique Martins Cayres. All rights reserved.
//

import UIKit
import Firebase

class MainCoordinator: Coordinator {

    var nextCoordinator: Coordinator?
    
    private let window: UIWindow?
    private let account: AccountManagerProtocol
    
    lazy var navigation: UINavigationController? = {
        window?.rootViewController as? UINavigationController
    }()
    
    init(window: UIWindow? = nil,
         account: AccountManagerProtocol = AccountManager()) {
        self.account = account
        self.window = window
    }
    
    @discardableResult func start() -> Coordinator {
        window?.rootViewController = UINavigationController()
        window?.makeKeyAndVisible()
        showSplash()
        return self
    }
    
    func verifyCredentials() {
        self.account.auth { [weak self] result in
            switch result {
            case let .success(auth): self?.startApp(for: auth)
            case let .failure(error): self?.handleModule(for: error)
            }
        }
    }
    
    func startApp(for status: AuthStatus) {
        switch status {
        case let .auth(user): self.startHome(for: user)
        }
    }
    
    func handleModule(for error: AuthError) {
        switch error {
        case let .FIRError(error): print(error)
        case .unknow: print("Algo desconhecido")
        }
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    
    func startHome(for user: User) {
        guard let navigation = navigation else { return }
        HomeCoordinator(presenting: navigation, user: user).start()
    }
    
    func showSplash() {
        let viewModel = SplashViewModel(coordinator: self,
                                        animationHandler: verifyCredentials)
        let view = SplashViewController(viewModel: viewModel)
        navigation?.pushViewController(view, animated: false)
        navigation?.setNavigationBarHidden(true, animated: false)
    }
    
    func showLogin() {
        let viewModel = LoginViewModel(coordinator: self)
        let view = LoginViewController(viewModel: viewModel)
        navigation?.pushViewController(view, animated: true)
        navigation?.setNavigationBarHidden(true, animated: true)
    }
    
    func showSignIn() {
        
    }
}
