//
//  SplashViewController.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 04/04/21.
//

import UIKit

class SplashViewController: UIViewController {
    
    let viewModel: SplashViewModelProtocol

    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SplashViewController: SplashViewProtocol {
    
}
