//
//  Untitled.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 06.09.2025.
//

import UIKit

final class AlbumCompositionalLayout {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
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
        guard sectionIndex < AlbumSection.allSections.count else {
            fatalError("Неизвестная секция: индекс \(sectionIndex) выходит за пределы")
        }
        
        let sectionType = AlbumSection.allSections[sectionIndex].type
        
        switch sectionType {
        case .myAlbums:
            return createMyAlbumsSection(environment: environment)
        case .sharedAlbums:
            return createSharedAlbumsSection(environment: environment)
        case .mediaTypes:
            return createMediaTypesSection(environment: environment)
        case .other:
            return createOtherAlbumsSection(environment: environment)
        }
    }
    
    private func createMyAlbumsSection(
        environment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        let contentWidth = environment.container.effectiveContentSize.width 
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
    
    private func createSharedAlbumsSection(
        environment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        let contentWidth = environment.container.effectiveContentSize.width
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
