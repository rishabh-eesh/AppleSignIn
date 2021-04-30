//
//  ResultViewController.swift
//  SignInWithApple
//
//  Created by Rishabh Dubey on 30/04/21.
//

import UIKit

class ResultViewController: UIViewController {
    
    let signoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(signoutButton)
        signoutButton.addTarget(self, action: #selector(handleSignout), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signoutButton.frame = .init(x: 0, y: 0, width: 100, height: 50)
        signoutButton.layer.cornerRadius = 10
        signoutButton.center = view.center
    }
    
    @objc fileprivate func handleSignout() {
        let controller = ViewController()
        controller.modalPresentationStyle = .formSheet
        controller.isModalInPresentation = true
        present(controller, animated: true)
    }
}
