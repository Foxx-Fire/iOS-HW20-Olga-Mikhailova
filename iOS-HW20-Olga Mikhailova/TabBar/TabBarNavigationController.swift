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
    
    //    private func createLibraryController() -> UIViewController {
    //        createNavigationController(
    //            rootViewController: LibraryViewController(),
    //            title: Constants.TabTitles.library,
    //            image: .system(name: Constants.TabIcons.library),
    //            selectedImage: .system(name: Constants.TabIcons.library)
    //        )
    //    }
    //    
    //    private func createForYouController() -> UIViewController {
    //        createNavigationController(
    //            rootViewController: ForYouViewController(),
    //            title: Constants.TabTitles.forYou,
    //            image: .system(name: Constants.TabIcons.forYou),
    //            selectedImage: .system(name: Constants.TabIcons.forYou)
    //        )
    //    }
    //    
    //    private func createAlbumsController() -> UIViewController {
    //        createNavigationController(
    //            rootViewController: AlbumsViewController(),
    //            title: Constants.TabTitles.albums,
    //            image: .custom(name: Constants.TabIcons.albums),
    //            selectedImage: .custom(name: Constants.TabIcons.albums)
    //        )
    //    }
    //    
    //    private func createSearchController() -> UIViewController {
    //        createNavigationController(
    //            rootViewController: SearchViewController(),
    //            title: Constants.TabTitles.search,
    //            image: .system(name: Constants.TabIcons.search),
    //            selectedImage: .system(name: Constants.TabIcons.search)
    //        )
// }
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
    
//    // MARK: - Private Helpers
//    
//    private func createNavigationController(rootViewController: UIViewController,
//                                            title: String,
//                                            image: TabBarImage,
//                                            selectedImage: TabBarImage) -> UINavigationController {
//        let navigationController = UINavigationController(
//            navigationBarClass: TallNavigationBar.self,
//            toolbarClass: nil
//        )
//        navigationController.viewControllers = [rootViewController]
//        
//        navigationController.tabBarItem = UITabBarItem(
//            title: title,
//            image: image.uiImage,
//            selectedImage: selectedImage.uiImage
//        )
//        
//        return navigationController
//    }
//}

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
