//
//  SearchTabBarViewController.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 11.08.2025.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        setupNavigation()
    }
    
    // MARK: - Setup Methods
    
    func setupNavigation() {
        configureNavigation(title: Constants.Navigation.title)
    }
}

// MARK: - Constants

extension SearchViewController {
    enum Constants {
        static let backgroundColor: UIColor = .yellow
        
        enum Navigation {
            static let title = "Search"
        }
    }
}
