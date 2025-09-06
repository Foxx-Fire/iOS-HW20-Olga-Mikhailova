//
//  AlbumsCollection.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 17.08.2025.
//

import UIKit
import SnapKit

final class AlbumCompositionalView: UIView {
    
    // MARK: - Outlets
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, environment in
            
            guard sectionIndex < SectionHeaderModel.allSections.count else {
                fatalError("Неизвестная секция: индекс \(sectionIndex) выходит за пределы")
            }
            
            // Получаем тип секции из модели
            let sectionType = SectionHeaderModel.allSections[sectionIndex].sectionType
            
            switch sectionType {
            case .myAlbums:
                // сбоку 16
                let side: CGFloat = 16
                // между двумя колонками в группе 12
                let interColumn: CGFloat = 12
                // между плитками в колонке 8
                let verticalSpacing: CGFloat = 8
                
                // реальная высота шрифта заголовка
                let titleLH = MyAlbumsCell.Constants.descriptionFont.lineHeight
                // реальная высота количества изображений
                let countLH = MyAlbumsCell.Constants.countFont.lineHeight
                // отступ сверху от картинки до стека
                let textH = MyAlbumsCell.Constants.stackTopOffset
                + MyAlbumsCell.Constants.stackSpacing
                + titleLH + countLH
                
                // ширина без боковых insets
                let contentW = environment.container.effectiveContentSize.width - side * 2
                // ширина одной колонки (2 колонки и зазор)
                let columnW = (contentW - interColumn) / 2
                // высота ячейки: квадратная картинка + текст
                let itemH = columnW + textH
                // высота вертикальной группы из 2 items
                let vGroupH = itemH * 2 + verticalSpacing
                
                // 1. Настройка элемента
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1), // 100% ширины колонки
                    heightDimension: .absolute(itemH) // фиксированная высота
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // 2. Вертикальная группа из 2 элементов (столбец)
                let verticalGroupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(columnW), // = ширина колонки
                    heightDimension: .absolute(vGroupH) // = сумма высот items + зазор
                )
                
                let verticalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: verticalGroupSize,
                    subitems: [item, item] // Два элемента в столбце
                )
                
                // 3. Основная горизонтальная группа из 2 вертикальных групп
                let planeGroupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(contentW), // = вся доступная ширина секции
                    heightDimension: .absolute(vGroupH) // = высота колонки
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: planeGroupSize,
                    subitems: [verticalGroup, verticalGroup] // Два столбца
                )
                group.interItemSpacing = .fixed(interColumn) // зазор между колонками
                
                // 4. Настройка секции
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = interColumn
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: .zero,
                    leading: side,
                    bottom: side,
                    trailing: side
                )
                
                // 4. Настройка хэдера для секции
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                
                section.boundarySupplementaryItems = [header]
                
                // Разделитель
                let separatorItem = NSCollectionLayoutDecorationItem.background(
                    elementKind: SectionSeparatorView.identifier
                )
                
                separatorItem.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 2,
                    bottom: 0,
                    trailing: 2
                )
                
                section.decorationItems = [separatorItem]
                
                return section
                
            case .sharedAlbums:
                let side: CGFloat = 16 // бок
                let titleLH = SharedAlbumsCell.Constants.descriptionFont.lineHeight
                let labelExtra = SharedAlbumsCell.Constants.stackTopOffset
                + SharedAlbumsCell.Constants.stackSpacing + titleLH * 2
                
                let contentW = environment.container.effectiveContentSize.width - side * 2 // доступная ширина секции
                let groupW = contentW * 0.48  // ширина одной карточки (2 рядом, с зазором)
                let itemH = groupW + labelExtra  // высота карточки (квадрат + подпись)
                
                // 1. Настройка элемента
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1.0), // заполняет группу по ширине
                        heightDimension: .absolute(itemH)
                    )
                )
                item.contentInsets = .zero   // внутренних insets у item нет
                
                // 2. Группа для горизонтального скролла
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(groupW),
                    heightDimension: .absolute(itemH)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                // 3. Настройка секции
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.interGroupSpacing = side // Расстояние между группами
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: side,
                    leading: side,
                    bottom: side,
                    trailing: side
                )
                
                // 4. Добавляем хэдер
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                
                section.boundarySupplementaryItems = [header]
                
                // Разделитель
                let separatorItem = NSCollectionLayoutDecorationItem.background(
                    elementKind: SectionSeparatorView.identifier
                )
                
                separatorItem.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 2,
                    bottom: 0,
                    trailing: 2
                )
                
                section.decorationItems = [separatorItem]
                
                return section
                
            case .mediaTypes, .otherAlbums:
                let side: CGFloat = 16 // бок
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(54)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: .zero,
                    leading: side,
                    bottom: .zero,
                    trailing: side
                )
                
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                
                section.boundarySupplementaryItems = [header]
                return section
            }
        }
        // глобальная конфигурация layout
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0 // между секциями
        layout.configuration = config // применяем конфиг
        layout.register( // решистрация сепаратора
            SectionSeparatorView.self,
            forDecorationViewOfKind: SectionSeparatorView.identifier
        )
        return layout
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
