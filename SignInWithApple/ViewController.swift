//
//  ViewController.swift
//  SignInWithApple
//
//  Created by Rishabh Dubey on 30/04/21.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    let signinAppleButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(signinAppleButton)
        signinAppleButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signinAppleButton.frame = .init(x: 0, y: 0, width: 250, height: 50)
        signinAppleButton.center = view.center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performExistingAccountSetupFlows()
    }
    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc fileprivate func didTapSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            let fullName = credential.fullName?.givenName
            let lastName = credential.fullName?.familyName
            let email = credential.email
            let userIdentifier = credential.user
            
            print(fullName, lastName, email, userIdentifier) //000769.7e02ba7916d348ed81f003a8495476fc.0733
            present(ResultViewController(), animated: true)
        
        case let passworkCredential as ASPasswordCredential:
            
            let username = passworkCredential.user
            let password = passworkCredential.password
            
            print("For the purpose of this demo app, show the password credential as an alert.")
            
            print(username, password)
        default:
            break
        }
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
