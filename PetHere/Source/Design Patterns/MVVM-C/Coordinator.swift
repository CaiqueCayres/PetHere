//
//  Coordinator.swift
//  CCoins
//
//  Created by Carlos Henrique Martins Cayres on 13/07/20.
//  Copyright © 2020 Carlos Henrique Martins Cayres. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    var nextCoordinator: Coordinator? { get set }
    func start() -> Coordinator
}

protocol PushedCoordinate: Coordinator {
    
    var presenting: UINavigationController { get }
    
    func loadInitialModule() -> UIViewController
    func introduces(viewController: UIViewController, animated: Bool)
}

extension PushedCoordinate {

    @discardableResult func start() -> Coordinator {
        introduces(viewController: loadInitialModule())
        return self
    }
    
    func introduces(viewController: UIViewController, animated: Bool = true) {
        //presenting.setNavigationBarHidden(false, animated: animated)
        presenting.pushViewController(viewController, animated: animated)
    }
}
