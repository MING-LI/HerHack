//
//  SceneDelegate.swift
//  HerHack
//
//  Created by Ken Li on 22/11/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        self.window = UIWindow(windowScene: scene as! UIWindowScene)
        self.window?.makeKeyAndVisible()
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(userStateDidChange),
          name: Notification.Name.AuthStateDidChange,
          object: nil
        )
        guard let _ = (scene as? UIWindowScene) else { return }
    }
        
    func handleStateChange() {
        if (Auth.auth().currentUser != nil) {
            self.window?.rootViewController = UINavigationController(rootViewController: HHTabbar())
        } else {
          self.window?.rootViewController = UINavigationController(rootViewController: LoginFormViewController())
        }
    }
    
    @objc func userStateDidChange() {
        DispatchQueue.main.async {
            self.handleStateChange()
        }
    }
}

