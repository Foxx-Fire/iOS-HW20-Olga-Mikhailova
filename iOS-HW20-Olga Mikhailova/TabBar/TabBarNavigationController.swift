//
//  TabBarController.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 12.08.2025.
//
import UIKit

protocol TabBarNavigationProtocol {
    func createAllControllers() -> [UIViewController]
}

final class TabBarNavigationController: TabBarNavigationProtocol {
    
    func createAllControllers() -> [UIViewController] {
        return [
            createController(
                rootViewController: LibraryViewController(),
                title: "Library",
                systemIcon: "photo.fill.on.rectangle.fill",
                customIcon: nil
            ),
            createController(
                rootViewController: ForYouViewController(),
                title: "For You",
                systemIcon: "heart.text.square.fill",
                customIcon: nil
            ),
            createController(
                rootViewController: AlbumsViewController(),
                title: "Albums",
                systemIcon: "rectangle.stack.fill", // Замена отсутствующей "albums"
                customIcon: nil
            ),
            createController(
                rootViewController: SearchViewController(),
                title: "Search",
                systemIcon: "magnifyingglass",
                customIcon: nil
            )
        ]
    }
    
        private func createController(rootViewController: UIViewController,
                                      title: String,
                                      systemIcon: String,
                                      customIcon: String?) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            
            // Приоритет у кастомной иконки, если она существует
            let image: UIImage?
            if let customIcon = customIcon, let customImage = UIImage(named: customIcon) {
                image = customImage
            } else {
                image = UIImage(systemName: systemIcon)
            }
            
            navController.tabBarItem = UITabBarItem(
                title: title,
                image: image,
                selectedImage: image
            )
            
            return navController
        }
    }

// MARK: - Constants

private extension TabBarNavigationController {
    enum Constants {
        enum TabTitles {
            static let library = "Library"
            static let forYou = "For You"
            static let albums = "Albums"
            static let search = "Search"
        }
        
        enum TabIcons {
            static let library = "photo.fill.on.rectangle.fill"
            static let forYou = "heart.text.square.fill"
            static let albums = "albums"
            static let search = "magnifyingglass"
        }
    }
    
    enum TabBarImage {
        case system(name: String)
        case custom(name: String)
        
        var uiImage: UIImage? {
            switch self {
            case .system(let name):
                return UIImage(systemName: name)
            case .custom(let name):
                return UIImage(named: name)
            }
        }
    }
}
