//
//  MediaTypesCelll.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 17.08.2025.
//

import UIKit
import SnapKit

final class MediaTypesCell: UICollectionViewCell {
    
    static let identifier = "MediaTypes"
    
    // MARK: - UI Elements
    
    private lazy var iconImageView = makeIconImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var countLabel = makeCountLabel()
    private lazy var chevronImageView = makeChevronImageView()
    private lazy var separatorView = makeSeparatorView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(separatorView)
    }
    
    private func setupLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.horizontalPadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(Constants.iconSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(Constants.textSpacing)
            make.centerY.equalToSuperview()
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Constants.horizontalPadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(Constants.chevronSize)
        }
        
        countLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-Constants.textSpacing)
            make.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-Constants.horizontalPadding)
            make.bottom.equalToSuperview()
            make.height.equalTo(Constants.separatorHeight)
        }
    }
    
    //MARK: - UIMethods
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.iconTintColor
        return imageView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.titleFont
        label.textColor = Constants.titleColor
        return label
    }
    
    private func makeCountLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.countFont
        label.textColor = Constants.countColor
        label.textAlignment = .right
        return label
    }
    
    private func makeChevronImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.chevronTintColor
        return imageView
    }
    
    private func makeSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = Constants.separatorColor
        return view
    }
    
    // MARK: - Configuration
    
    func configuration(model: MediaAndOther) {
        iconImageView.image = UIImage(systemName: model.imageName)
        titleLabel.text = model.title
        countLabel.text = "\(model.count)"
        chevronImageView.image = UIImage(systemName: model.chevronName)
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
        countLabel.text = nil
    }
}

// MARK: - Constants

private extension MediaTypesCell {
    enum Constants {
        static let horizontalPadding: CGFloat = 1
        static let textSpacing: CGFloat = 12
        static let iconSize: CGFloat = 28
        static let chevronSize: CGFloat = 12
        static let separatorHeight: CGFloat = 0.5
        static let iconTintColor: UIColor = .systemBlue
        static let titleColor: UIColor = .systemBlue
        static let countColor: UIColor = .systemGray
        static let chevronTintColor: UIColor = .systemGray
        static let separatorColor: UIColor = .systemGray5
        static let titleFont: UIFont = .systemFont(ofSize: 20, weight: .medium)
        static let countFont: UIFont = .systemFont(ofSize: 16)
    }
}
