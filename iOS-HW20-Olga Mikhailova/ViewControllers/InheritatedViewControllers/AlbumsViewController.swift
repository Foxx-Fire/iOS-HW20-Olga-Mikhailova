//
//  AlbumsTabBarViewController.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 11.08.2025.
//

import UIKit

class AlbumsViewController: BaseViewController{
    
    private let albumsView = AlbumCompositionalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
        setupLayout()
        setupHierarchy()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        view.backgroundColor = Constants.backgroundColor
    }
    
    func setupNavigation() {
        let addAction = UIAction { _ in
            print("Add button tapped in Albums")
        }
        
        configureNavigation(
            title: Constants.Navigation.title,
            showButton: true,
            buttonImage: Constants.Navigation.buttonImageName,
            buttonAction: addAction
        )
    }
    
    private func setupLayout() {
        view.addSubview(albumsView)
    }
    
    private func setupHierarchy() {
        albumsView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Constants
extension AlbumsViewController {
    enum Constants {
        enum Navigation {
            static let title = "Albums"
            static let buttonImageName = "plus"
        }

        static let backgroundColor: UIColor = .white
    }
}



