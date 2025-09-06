//
//  MaketViewController.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 15.08.2025.
//

import UIKit

 class BaseViewController: UIViewController {
    
    private let navigation = NavigationAppearanceManager()
    
    // MARK: - UI Elements
    
    private lazy var navigationTitleLabel = makeNavigationTitleLabel()
    private lazy var navigationAddButton = makeNavigationAddButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        navigation.setupGlobalAppearance()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        view.backgroundColor = .cyan
    }
    
    // MARK: - Public Navigation Methods
    
    func configureNavigation(
        title: String,
        showButton: Bool = false,
        buttonImage: String? = nil,
        buttonAction: UIAction? = nil
    ) {
            navigationItem.title = title
            
            if showButton {
                if let buttonImage = buttonImage {
                    navigationAddButton.image = UIImage(systemName: buttonImage)
                }
                
                if let buttonAction {
                    navigationAddButton.primaryAction = buttonAction
                }
                
                navigationItem.leftBarButtonItem = navigationAddButton
            } else {
                navigationItem.leftBarButtonItem = nil
            }
        }
    
    //MARK: - UIMethods
    
    private func makeNavigationTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: Constants.navigationTitleFontSize,
            weight: Constants.navigationTitleFontWeight
        )
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func makeNavigationAddButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(
            systemItem: .add,
            primaryAction: UIAction { _ in
                print("Add button tapped in Albums")
            }
        )
     
        button.tintColor = Constants.buttonTintColor
        return button
    }
}

// MARK: - Constants
extension BaseViewController {
    enum Constants {
        static let navigationTitleFontSize: CGFloat = 34
        static let navigationTitleFontWeight: UIFont.Weight = .bold
        static let buttonTintColor: UIColor = .blue
    }
}
