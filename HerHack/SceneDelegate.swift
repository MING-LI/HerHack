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
        
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(userStateDidChange),
          name: Notification.Name.AuthStateDidChange,
          object: nil
        )
        
        self.window = UIWindow(windowScene: scene as! UIWindowScene)
        self.window?.makeKeyAndVisible()
        self.handleStateChange()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
        
    func handleStateChange() {
        if let user = Auth.auth().currentUser {
            UserSettings.uid = user.uid
            FirestoreService.shared.retrieveUserBy(user.uid, completion: { user in
                UserSettings.name = user.name
            })
            self.window?.rootViewController = HHTabbar()
        } else {
            self.window?.rootViewController = LoginFormViewController()
        }
    }
    
    @objc func userStateDidChange() {
        DispatchQueue.main.async {
//            self.handleStateChange()
        }
    }
}

