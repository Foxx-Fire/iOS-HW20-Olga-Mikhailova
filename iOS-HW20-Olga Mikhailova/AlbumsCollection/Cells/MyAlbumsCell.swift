//
//  MyAlbumsCell.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 17.08.2025.
//

import UIKit

final class MyAlbumsCell: UICollectionViewCell {
    
    static let identifier = "MyAlbumsCell"
    
    // MARK: - UI Elements
    
    private lazy var imageView = makeImageView()
    private lazy var descriptionLabel = makeDescriptionLabel()
    private lazy var countLabel = makeCountLabel()
    private lazy var stackView = makeStackView()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("ERROR")
    }
    
    //MARK: - Setups
    
    private func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(countLabel)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.stackTopOffset)
            make.leading.equalTo(imageView.snp.leading)
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: - UIMethods
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.imageCornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = Constants.imageBackgroundColor
        return imageView
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.descriptionFont
        label.textColor = Constants.descriptionColor
        return label
    }
    
    private func makeCountLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.countFont
        label.textColor = Constants.countColor
        return label
    }
    
    private func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing
        stack.alignment = .leading
        return stack
    }
    
    // MARK: - Configuration
    
    func configuration(model: MyAlbum) {
        imageView.image = UIImage(named: model.imageName)
        descriptionLabel.text = model.title
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        countLabel.text = formatter.string(
            from: NSNumber(value: model.count)
        ) ?? "\(model.count)"
        
        if let image = UIImage(named: model.imageName) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: Constants.placeholderImageName)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        descriptionLabel.text = nil
        countLabel.text = nil
    }
}

// MARK: - Constants

extension MyAlbumsCell {
    enum Constants {
        static let imageCornerRadius: CGFloat = 8
        static let stackTopOffset: CGFloat = 8
        static let stackSpacing: CGFloat = 2
        static let imageBackgroundColor: UIColor = .systemGray5
        static let descriptionColor: UIColor = .black
        static let countColor: UIColor = .gray
        static let descriptionFont: UIFont = .systemFont(ofSize: 14)
        static let countFont: UIFont = .systemFont(ofSize: 12)
        static let placeholderImageName = "photo.on.rectangle"
    }
}
