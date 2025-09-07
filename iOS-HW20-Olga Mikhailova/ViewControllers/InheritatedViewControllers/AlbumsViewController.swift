//
//  AlbumsTabBarViewController.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 11.08.2025.
//

import UIKit

final class AlbumsViewController: BaseViewController{
    
    // MARK: - Properties
    
    private let layout = AlbumCompositionalLayout()
    
    // MARK: - Outlets
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout:  layout.createLayout())
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
        setupHierarchy()
        setupLayout()
        registerCollectionViewCells()
    }
    
    // MARK: - Registration
    
    private func registerCollectionViewCells() {
        collectionView.register(
            MyAlbumsCell.self,
            forCellWithReuseIdentifier: MyAlbumsCell.identifier
        )
        collectionView.register(
            AlbumsHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: AlbumsHeaderView.identifier
        )
        collectionView.register(
            SharedAlbumsFirstCell.self,
            forCellWithReuseIdentifier: SharedAlbumsFirstCell.identifier
        )
        collectionView.register(
            SharedAlbumsCell.self,
            forCellWithReuseIdentifier: SharedAlbumsCell.identifier
        )
        collectionView.register(
            MediaTypesCell.self,
            forCellWithReuseIdentifier: MediaTypesCell.identifier
        )
        collectionView.register(
            OtherAlbumsCell.self,
            forCellWithReuseIdentifier: OtherAlbumsCell.identifier
        )
    }
    
    // MARK: - Setup
    
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
    
    private func setupHierarchy() {
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        registerCollectionViewCells()
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

// MARK: - UICollectionViewDelegate

extension AlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Снимаем выделение с анимацией
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    // Определяет количество секций в коллекции
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return AlbumSection.allSections.count
    }
    
    // Определяет количество ячеек в конкретной секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let albumSection = AlbumSection.allSections[section]
        return albumSection.items.count
    }
    
    // Создает и настраивает ячейку для конкретной позиции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let albumSection = AlbumSection.allSections[indexPath.section]
        let item = albumSection.items[indexPath.item]
        
        switch item {
        case .myAlbum(let myAlbum):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyAlbumsCell.identifier,
                for: indexPath
            ) as? MyAlbumsCell else {
                return UICollectionViewCell()
            }
            cell.configuration(model: myAlbum)
            return cell
            
        case .firstSharedAlbum(let firstSharedAlbum):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SharedAlbumsFirstCell.identifier,
                for: indexPath
            ) as? SharedAlbumsFirstCell else {
                return UICollectionViewCell()
            }
            cell.configuration(model: firstSharedAlbum)
            return cell
            
        case .sharedAlbum(let sharedAlbum):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SharedAlbumsCell.identifier,
                for: indexPath
            ) as? SharedAlbumsCell else {
                return UICollectionViewCell()
            }
            cell.configuration(model: sharedAlbum)
            return cell
            
        case .mediaType(let mediaType):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MediaTypesCell.identifier,
                for: indexPath
            ) as? MediaTypesCell else {
                return UICollectionViewCell()
            }
            cell.configuration(model: mediaType)
            return cell
            
        case .other(let otherType):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OtherAlbumsCell.identifier,
                for: indexPath
            ) as? OtherAlbumsCell else {
                return UICollectionViewCell()
            }
            cell.configuration(model: otherType)
            return cell
        }
    }
    
    //MARK: - настройки хэдера
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: AlbumsHeaderView.identifier,
            for: indexPath
        ) as? AlbumsHeaderView else {
            return UICollectionReusableView()
        }
        
        let albumSection = AlbumSection.allSections[indexPath.section]
        header.configuration(model: albumSection.header)
        return header
    }
}





