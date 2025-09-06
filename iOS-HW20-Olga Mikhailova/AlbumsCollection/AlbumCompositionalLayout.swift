//
//  Untitled.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 06.09.2025.
//

import UIKit

final class AlbumCompositionalLayout {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            self?.createSection(for: sectionIndex, environment: environment)
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        layout.configuration = config
        layout.register(
            SectionSeparatorView.self,
            forDecorationViewOfKind: SectionSeparatorView.identifier
        )
        
        return layout
    }
    
    private func createSection(for sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        guard sectionIndex < SectionHeaderModel.allSections.count else {
            fatalError("Неизвестная секция: индекс \(sectionIndex) выходит за пределы")
        }
        
        let sectionType = SectionHeaderModel.allSections[sectionIndex].sectionType
        
        switch sectionType {
        case .myAlbums:
            return createMyAlbumsSection(environment: environment)
        case .sharedAlbums:
            return createSharedAlbumsSection(environment: environment)
        case .mediaTypes:
            return createMediaTypesSection(environment: environment)
        case .otherAlbums:
            return createOtherAlbumsSection(environment: environment)
        }
    }
    
    private func createMyAlbumsSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let contentWidth = environment.container.effectiveContentSize.width - Constants.sidePadding * 2
        let columnWidth = (contentWidth - Constants.interColumnSpacing) / 2
        let itemHeight = calculateMyAlbumsItemHeight(columnWidth: columnWidth)
        let verticalGroupHeight = itemHeight * 2 + Constants.verticalSpacing
        
        // Создаем элементы
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Вертикальная группа из 2 элементов
        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(columnWidth),
            heightDimension: .absolute(verticalGroupHeight)
        )
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            subitems: [item, item]
        )
        
        // Основная горизонтальная группа
        let horizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(contentWidth),
            heightDimension: .absolute(verticalGroupHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: horizontalGroupSize,
            subitems: [verticalGroup, verticalGroup]
        )
        group.interItemSpacing = .fixed(Constants.interColumnSpacing)
        
        // Настраиваем секцию
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = Constants.interColumnSpacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: Constants.sidePadding,
            bottom: Constants.sidePadding,
            trailing: Constants.sidePadding
        )
        
        addHeader(to: section)
        addSeparator(to: section)
        
        return section
    }
    
    private func createSharedAlbumsSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let contentWidth = environment.container.effectiveContentSize.width - Constants.sidePadding * 2
        let groupWidth = contentWidth * Constants.sharedAlbumsCardWidthMultiplier
        let itemHeight = calculateSharedAlbumsItemHeight(groupWidth: groupWidth)
        
        // Создаем элемент
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(itemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .zero
        
        // Создаем группу
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(groupWidth),
            heightDimension: .absolute(itemHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        // Настраиваем секцию
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = Constants.sidePadding
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.sidePadding,
            leading: Constants.sidePadding,
            bottom: Constants.sidePadding,
            trailing: Constants.sidePadding
        )
        
        addHeader(to: section)
        addSeparator(to: section)
        
        return section
    }
    
    private func createMediaTypesSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        return createListStyleSection(environment: environment)
    }
    
    private func createOtherAlbumsSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        return createListStyleSection(environment: environment)
    }
    
    private func createListStyleSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Создаем элемент
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(Constants.listItemEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Создаем группу
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(Constants.listGroupEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        // Настраиваем секцию
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: Constants.sidePadding,
            bottom: .zero,
            trailing: Constants.sidePadding
        )
        
        addHeader(to: section)
        
        return section
    }
    
    // MARK: - Helper Methods
    
    private func addHeader(to section: NSCollectionLayoutSection) {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(Constants.headerHeight)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
    }
    
    private func addSeparator(to section: NSCollectionLayoutSection) {
        let separatorItem = NSCollectionLayoutDecorationItem.background(
            elementKind: SectionSeparatorView.identifier
        )
        
        separatorItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: Constants.separatorInset,
            bottom: 0,
            trailing: Constants.separatorInset
        )
        
        section.decorationItems = [separatorItem]
    }
    
//    func createLayout() -> UICollectionViewCompositionalLayout {
//        let layout = UICollectionViewCompositionalLayout {
//            sectionIndex, environment in
//            
//            guard sectionIndex < SectionHeaderModel.allSections.count else {
//                fatalError("Неизвестная секция: индекс \(sectionIndex) выходит за пределы")
//            }
//            
//            // Получаем тип секции из модели
//            let sectionType = SectionHeaderModel.allSections[sectionIndex].sectionType
//            
//            switch sectionType {
//            case .myAlbums:
//                // сбоку 16
//                let side: CGFloat = 16
//                // между двумя колонками в группе 12
//                let interColumn: CGFloat = 12
//                // между плитками в колонке 8
//                let verticalSpacing: CGFloat = 8
//                
//                // реальная высота шрифта заголовка
//                let titleLH = MyAlbumsCell.Constants.descriptionFont.lineHeight
//                // реальная высота количества изображений
//                let countLH = MyAlbumsCell.Constants.countFont.lineHeight
//                // отступ сверху от картинки до стека
//                let textH = MyAlbumsCell.Constants.stackTopOffset
//                + MyAlbumsCell.Constants.stackSpacing
//                + titleLH + countLH
//                
//                // ширина без боковых insets
//                let contentW = environment.container.effectiveContentSize.width - side * 2
//                // ширина одной колонки (2 колонки и зазор)
//                let columnW = (contentW - interColumn) / 2
//                // высота ячейки: квадратная картинка + текст
//                let itemH = columnW + textH
//                // высота вертикальной группы из 2 items
//                let vGroupH = itemH * 2 + verticalSpacing
//                
//                // 1. Настройка элемента
//                let itemSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1), // 100% ширины колонки
//                    heightDimension: .absolute(itemH) // фиксированная высота
//                )
//                
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                
//                // 2. Вертикальная группа из 2 элементов (столбец)
//                let verticalGroupSize = NSCollectionLayoutSize(
//                    widthDimension: .absolute(columnW), // = ширина колонки
//                    heightDimension: .absolute(vGroupH) // = сумма высот items + зазор
//                )
//                
//                let verticalGroup = NSCollectionLayoutGroup.vertical(
//                    layoutSize: verticalGroupSize,
//                    subitems: [item, item] // Два элемента в столбце
//                )
//                
//                // 3. Основная горизонтальная группа из 2 вертикальных групп
//                let planeGroupSize = NSCollectionLayoutSize(
//                    widthDimension: .absolute(contentW), // = вся доступная ширина секции
//                    heightDimension: .absolute(vGroupH) // = высота колонки
//                )
//                
//                let group = NSCollectionLayoutGroup.horizontal(
//                    layoutSize: planeGroupSize,
//                    subitems: [verticalGroup, verticalGroup] // Два столбца
//                )
//                group.interItemSpacing = .fixed(interColumn) // зазор между колонками
//                
//                // 4. Настройка секции
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .continuous
//                section.interGroupSpacing = interColumn
//                section.contentInsets = NSDirectionalEdgeInsets(
//                    top: .zero,
//                    leading: side,
//                    bottom: side,
//                    trailing: side
//                )
//                
//                // 4. Настройка хэдера для секции
//                let headerSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .estimated(44)
//                )
//                
//                let header = NSCollectionLayoutBoundarySupplementaryItem(
//                    layoutSize: headerSize,
//                    elementKind: UICollectionView.elementKindSectionHeader,
//                    alignment: .top
//                )
//                
//                section.boundarySupplementaryItems = [header]
//                
//                // Разделитель
//                let separatorItem = NSCollectionLayoutDecorationItem.background(
//                    elementKind: SectionSeparatorView.identifier
//                )
//                
//                separatorItem.contentInsets = NSDirectionalEdgeInsets(
//                    top: 0,
//                    leading: 2,
//                    bottom: 0,
//                    trailing: 2
//                )
//                
//                section.decorationItems = [separatorItem]
//                
//                return section
//                
//            case .sharedAlbums:
//                let side: CGFloat = 16 // бок
//                let titleLH = SharedAlbumsCell.Constants.descriptionFont.lineHeight
//                let labelExtra = SharedAlbumsCell.Constants.stackTopOffset
//                + SharedAlbumsCell.Constants.stackSpacing + titleLH * 2
//                
//                let contentW = environment.container.effectiveContentSize.width - side * 2 // доступная ширина секции
//                let groupW = contentW * 0.48  // ширина одной карточки (2 рядом, с зазором)
//                let itemH = groupW + labelExtra  // высота карточки (квадрат + подпись)
//                
//                // 1. Настройка элемента
//                let item = NSCollectionLayoutItem(
//                    layoutSize: .init(
//                        widthDimension: .fractionalWidth(1.0), // заполняет группу по ширине
//                        heightDimension: .absolute(itemH)
//                    )
//                )
//                item.contentInsets = .zero   // внутренних insets у item нет
//                
//                // 2. Группа для горизонтального скролла
//                let groupSize = NSCollectionLayoutSize(
//                    widthDimension: .absolute(groupW),
//                    heightDimension: .absolute(itemH)
//                )
//                
//                let group = NSCollectionLayoutGroup.horizontal(
//                    layoutSize: groupSize,
//                    subitems: [item]
//                )
//                
//                // 3. Настройка секции
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
//                section.interGroupSpacing = side // Расстояние между группами
//                section.contentInsets = NSDirectionalEdgeInsets(
//                    top: side,
//                    leading: side,
//                    bottom: side,
//                    trailing: side
//                )
//                
//                // 4. Добавляем хэдер
//                let headerSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .estimated(44)
//                )
//                
//                let header = NSCollectionLayoutBoundarySupplementaryItem(
//                    layoutSize: headerSize,
//                    elementKind: UICollectionView.elementKindSectionHeader,
//                    alignment: .top
//                )
//                
//                section.boundarySupplementaryItems = [header]
//                
//                // Разделитель
//                let separatorItem = NSCollectionLayoutDecorationItem.background(
//                    elementKind: SectionSeparatorView.identifier
//                )
//                
//                separatorItem.contentInsets = NSDirectionalEdgeInsets(
//                    top: 0,
//                    leading: 2,
//                    bottom: 0,
//                    trailing: 2
//                )
//                
//                section.decorationItems = [separatorItem]
//                
//                return section
//                
//            case .mediaTypes, .otherAlbums:
//                let side: CGFloat = 16 // бок
//                
//                let itemSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .estimated(54)
//                )
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                
//                let groupSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .estimated(44)
//                )
//                let group = NSCollectionLayoutGroup.horizontal(
//                    layoutSize: groupSize,
//                    subitems: [item]
//                )
//                
//                let section = NSCollectionLayoutSection(group: group)
//                section.contentInsets = NSDirectionalEdgeInsets(
//                    top: .zero,
//                    leading: side,
//                    bottom: .zero,
//                    trailing: side
//                )
//                
//                let headerSize = NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1.0),
//                    heightDimension: .estimated(44)
//                )
//                
//                let header = NSCollectionLayoutBoundarySupplementaryItem(
//                    layoutSize: headerSize,
//                    elementKind: UICollectionView.elementKindSectionHeader,
//                    alignment: .top
//                )
//                
//                section.boundarySupplementaryItems = [header]
//                return section
//            }
//        }
//        // глобальная конфигурация layout
//        let config = UICollectionViewCompositionalLayoutConfiguration()
//        config.interSectionSpacing = 0 // между секциями
//        layout.configuration = config // применяем конфиг
//        layout.register( // решистрация сепаратора
//            SectionSeparatorView.self,
//            forDecorationViewOfKind: SectionSeparatorView.identifier
//        )
//        return layout
//    }
}

// MARK: - Constants

private extension AlbumCompositionalLayout {
    
    enum Constants {
        // Общие константы
        static let sidePadding: CGFloat = 16
        static let interColumnSpacing: CGFloat = 12
        static let verticalSpacing: CGFloat = 8
        static let headerHeight: CGFloat = 44
        static let separatorInset: CGFloat = 2
        
        // MyAlbums
        static let myAlbumsStackTopOffset: CGFloat = 8
        static let myAlbumsStackSpacing: CGFloat = 2
        static let myAlbumsDescriptionFont = UIFont.systemFont(ofSize: 14)
        static let myAlbumsCountFont = UIFont.systemFont(ofSize: 12)
        
        // SharedAlbums
        static let sharedAlbumsStackTopOffset: CGFloat = 8
        static let sharedAlbumsStackSpacing: CGFloat = 2
        static let sharedAlbumsDescriptionFont = UIFont.systemFont(ofSize: 14)
        static let sharedAlbumsCardWidthMultiplier: CGFloat = 0.48
        
        // MediaTypes and OtherAlbums
        static let listItemEstimatedHeight: CGFloat = 54
        static let listGroupEstimatedHeight: CGFloat = 44
    }
    
    // Calculatings
    func calculateMyAlbumsItemHeight(columnWidth: CGFloat) -> CGFloat {
        let titleLineHeight = Constants.myAlbumsDescriptionFont.lineHeight
        let countLineHeight = Constants.myAlbumsCountFont.lineHeight
        let textHeight = Constants.myAlbumsStackTopOffset +
        Constants.myAlbumsStackSpacing +
        titleLineHeight + countLineHeight
        return columnWidth + textHeight
    }
    
    func calculateSharedAlbumsItemHeight(groupWidth: CGFloat) -> CGFloat {
        let titleLineHeight = Constants.sharedAlbumsDescriptionFont.lineHeight
        let labelExtra = Constants.sharedAlbumsStackTopOffset +
        Constants.sharedAlbumsStackSpacing +
        titleLineHeight * 2
        return groupWidth + labelExtra
    }
}
