//
//  TabBar.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 11.08.2025.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        setupTabBarController()
        setupTabBarViewControllers()
    }
    
    private func setupTabBarController() {
        let lightGrayColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        tabBar.backgroundColor = lightGrayColor
        tabBar.tintColor = .systemBlue
        tabBar.isTranslucent = false
    }
    
    func setupTabBarViewControllers() {
        // Library
        let library = LibraryViewController()
        let libraryItem = UITabBarItem(
            title: "Library",
            image: UIImage(systemName: "photo.fill.on.rectangle.fill"),
            selectedImage: UIImage(systemName: "photo.fill.on.rectangle.fill")
        )
        library.tabBarItem = libraryItem
        
        // ForYou
        let forYou = ForYouViewController()
        let forYouItem = UITabBarItem(
            title: "Library",
            image: UIImage(systemName: "photo.fill.on.rectangle.fill"),
            selectedImage: UIImage(systemName: "photo.fill.on.rectangle.fill"
                                  )
        )
        forYou.tabBarItem = forYouItem
        
        // Albums
        let albums = AlbumsViewController()
        let albumsItem = UITabBarItem(
            title: "Library",
            image: UIImage(named: "albums"),
            selectedImage: UIImage(named: "albums")
        )
        albums.tabBarItem = albumsItem
        
        // Search
        let search = SearchViewController()
        let searchItem = UITabBarItem(
            title: "Library",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        search.tabBarItem = searchItem
        
        let controllers = [library, forYou, albums, search]
        self.setViewControllers(controllers, animated: true)
    }
}

