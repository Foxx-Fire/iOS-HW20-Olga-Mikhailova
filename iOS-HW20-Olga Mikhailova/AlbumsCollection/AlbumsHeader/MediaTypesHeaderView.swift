//
//  MediaTypesHeaderView.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 21.08.2025.
//

import UIKit

final class MediaTypesHeaderView: UICollectionReusableView {
    
    static let identifier = "MediaTypesHeaderView"
    
    //MARK: - UI Elements
    
    private lazy var titleLabel = makeTitleLabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
    }
    
    //MARK: - UIMethods
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.titleColor
        label.font = Constants.titleFont
        return label
    }
    
    // MARK: - Configuration
    
    func configuration(model: SectionHeaderModel) {
        titleLabel.text = model.title
    }
    
    //MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}

// MARK: - Constants

private extension MediaTypesHeaderView {
    enum Constants {
        static let horizontalPadding: CGFloat = 16
        static let titleColor: UIColor = .black
        static let titleFont: UIFont = .systemFont(ofSize: 22, weight: .bold)
    }
}
