//
//  SceneDelegate.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 11.08.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let navigationManager = NavigationAppearanceManager()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        navigationManager.setupGlobalAppearance()
        
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
    }
}



