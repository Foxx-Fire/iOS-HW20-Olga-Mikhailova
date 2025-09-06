//
//  AlbumsCollection.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 17.08.2025.
//

import UIKit
import SnapKit

final class AlbumCompositionalView: UIView {
    
    private let layout = AlbumCompositionalLayout()
    
    // MARK: - Outlets
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout:  layout.createLayout())
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
        registerCollectionViewCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            SharedHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SharedHeaderView.identifier
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
    
    private func setupHierarchy() {
        addSubview(collectionView)
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

// MARK: - UICollectionViewDelegate

extension AlbumCompositionalView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Снимаем выделение с анимацией
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension AlbumCompositionalView: UICollectionViewDataSource {
    // Определяет количество секций в коллекции
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionHeaderModel.allSections.count
    }
    
    // Определяет количество ячеек в конкретной секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SectionHeaderModel.allSections[section].sectionType
        
        switch sectionType {
        case .myAlbums:
            return MyAlbum.myAlbum.count
        case .sharedAlbums:
            // Первая ячейка с кружочками + остальные из SharedAlbum.sharedAlbum
            return 1 + SharedAlbum.sharedAlbum.count
        case .mediaTypes:
            return MediaAndOther.mediaType.count
        case .otherAlbums:
            return MediaAndOther.otherType.count
        }
    }
    
    // Создает и настраивает ячейку для конкретной позиции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = SectionHeaderModel.allSections[indexPath.section].sectionType
        
        switch sectionType {
        case .myAlbums:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyAlbumsCell.identifier,
                for: indexPath
            ) as! MyAlbumsCell
            cell.configuration(model: MyAlbum.myAlbum[indexPath.item])
            return cell
            
        case .sharedAlbums:
            if indexPath.item == 0 {
                // Первая ячейка с 4 кружочками
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SharedAlbumsFirstCell.identifier,
                    for: indexPath
                ) as! SharedAlbumsFirstCell
                cell.configuration(model: FirstSharedAlbum.firstSharedAlbum)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SharedAlbumsCell.identifier,
                    for: indexPath
                ) as! SharedAlbumsCell
                let sharedAlbum = SharedAlbum.sharedAlbum[indexPath.item - 1]
                cell.configuration(model: sharedAlbum)
                return cell
            }
        case .mediaTypes:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MediaTypesCell.identifier,
                for: indexPath
            ) as! MediaTypesCell
            cell.configuration(model: MediaAndOther.mediaType[indexPath.item])
            
            return cell
        case .otherAlbums:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OtherAlbumsCell.identifier,
                for: indexPath
            ) as! OtherAlbumsCell
            cell.configuration(model: MediaAndOther.otherType[indexPath.item])
            
            return cell
        }
    }
    
    //MARK: - настройки хэдера
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionType = SectionHeaderModel.allSections[indexPath.section].sectionType
        
        switch sectionType {
        case .myAlbums:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AlbumsHeaderView.identifier,
                for: indexPath
            ) as! AlbumsHeaderView
            header.configuration(model: SectionHeaderModel.allSections[indexPath.section])
            return header
            
        case .sharedAlbums:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SharedHeaderView.identifier, // Используйте SharedHeaderView
                for: indexPath
            ) as! SharedHeaderView
            header.configuration(model: SectionHeaderModel.allSections[indexPath.section])
            return header
            
        case .mediaTypes, .otherAlbums:
            // Для остальных секций
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AlbumsHeaderView.identifier,
                for: indexPath
            ) as! AlbumsHeaderView
            header.configuration(model: SectionHeaderModel.allSections[indexPath.section])
            return header
        }
    }
}
