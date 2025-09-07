//
//  NavigationAppearanceManager.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 12.08.2025.
//

import UIKit

final class NavigationAppearanceManager {
    
    func setupGlobalAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.backgroundColor
        appearance.largeTitleTextAttributes = [
            .foregroundColor: Constants.titleColor,
            .font: Constants.titleFont
        ]
        appearance.shadowColor = .clear
        
        UINavigationBar.appearance().tintColor = .systemBlue
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().isTranslucent = false
    }
 
}

// MARK: - Constants
private extension NavigationAppearanceManager {
    enum Constants {
        static let backgroundColor: UIColor = .white
        static let titleColor: UIColor = .black
        static let buttonTintColor: UIColor = .black
        static let titleFont = UIFont.systemFont(ofSize: 34, weight: .bold)
        static let containerMargins = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        static let containerTopInset: CGFloat = 10
        static let minContainerWidth: CGFloat = 300
        
        static let titleTopOffset: CGFloat = 34
        static let titleButtonSpacing: CGFloat = 4
        static let buttonSize = CGSize(width: 30, height: 30)
    }
}


