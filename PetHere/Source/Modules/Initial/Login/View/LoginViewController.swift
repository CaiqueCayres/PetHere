//
//  LoginViewController.swift
//  PetHere
//
//  Created by Carlos Henrique Cayres on 04/04/21.
//

import UIKit

class LoginViewController: UIViewController {

    private let viewModel: LoginViewModelProtocol

    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewController: LoginViewProtocol {
    
}
