//
//  SceneDelegate.swift
//  HerHack
//
//  Created by Ken Li on 22/11/2019.
//  Copyright © 2019 pdni. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        self.window = UIWindow(windowScene: scene as! UIWindowScene)
        self.window?.makeKeyAndVisible()
        
        let landingScreen = UINavigationController(rootViewController: LoginFormViewController())
        
        self.window?.rootViewController = landingScreen

        guard let _ = (scene as? UIWindowScene) else { return }
    }

}

