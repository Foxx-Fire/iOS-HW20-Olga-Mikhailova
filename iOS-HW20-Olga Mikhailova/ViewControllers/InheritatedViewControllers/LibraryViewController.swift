//
//  LibraryViewController.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 11.08.2025.
//

import UIKit

final class LibraryViewController: BaseViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        setupNavigation()
    }
    
    // MARK: - Setups
    
    func setupNavigation() {
        configureNavigation(title: Constants.Navigation.title)
    }
}

// MARK: - Constants
extension LibraryViewController {
    enum Constants {
        static let backgroundColor: UIColor = .green
        
        enum Navigation {
            static let title = "Library"
        }
    }
}
