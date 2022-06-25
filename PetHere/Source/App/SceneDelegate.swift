//
//  SceneDelegate.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 30/03/21.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    lazy var window: UIWindow? = {
        return UIWindow()
    }()

    lazy var mainCoordinator: MainCoordinator = {
        let coordinator = MainCoordinator(window: window)
        return coordinator
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        mainCoordinator.start()
    }
}

