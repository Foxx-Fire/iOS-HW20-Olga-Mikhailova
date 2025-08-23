//
//  TabBar.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 11.08.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Properties
    private let tabBarNavigation: TabBarNavigationProtocol
    
    // MARK: - Initialization
    init(tabBarNavigation: TabBarNavigationProtocol = TabBarNavigationController()) {
        self.tabBarNavigation = tabBarNavigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
        viewControllers = tabBarNavigation.createAllControllers()
    }
    
    // MARK: - Private Methods
    private func setupTabBarController() {
        tabBar.backgroundColor = Constants.backgroundColor
        tabBar.unselectedItemTintColor = Constants.unselectedItemColor
        tabBar.tintColor = Constants.selectedItemColor
        tabBar.isTranslucent = Constants.isTranslucent
    }
}

// MARK: - Constants
private extension TabBarViewController {
    enum Constants {
        static let backgroundColor = UIColor(
            red: 0.96,
            green: 0.96,
            blue: 0.96,
            alpha: 1.0
        )
        static let unselectedItemColor = UIColor(
            red: 0.6,
            green: 0.6,
            blue: 0.6,
            alpha: 1.0
        )
        static let selectedItemColor: UIColor = .systemBlue
        static let isTranslucent = false
    }
}
