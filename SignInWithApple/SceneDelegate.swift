//
//  SceneDelegate.swift
//  SignInWithApple
//
//  Created by Rishabh Dubey on 30/04/21.
//

import UIKit
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.windowScene = windowScene
        let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: "000769.7e02ba7916d348ed81f003a8495476fc.0733") { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    // The Apple ID credential is valid.
                    DispatchQueue.main.async {
                        self.window?.rootViewController = ResultViewController()
                        self.window?.makeKeyAndVisible()
                    }
                case .revoked, .notFound:
                    // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                    DispatchQueue.main.async {
                        self.window?.rootViewController = ViewController()
                        self.window?.makeKeyAndVisible()
                    }
                debugPrint("The Apple ID credential is either revoked or was not found, so show the sign-in UI.")
                default:
                    break
                }
            }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

