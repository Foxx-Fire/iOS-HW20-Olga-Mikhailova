//
//  AlbumsHeader.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 17.08.2025.
//

import UIKit

class AlbumsHeaderView: UICollectionReusableView {
    
    static let identifier = "AlbumsHeaderView"
    
    // MARK: - Properties
    
    private var buttonAction: (() -> Void)?
    //    private var hasButton: Bool = false
    
    //MARK: - UI Elements
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var seeAllButton = makeSeeAllButton()
    
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
        addSubview(seeAllButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.centerY.equalTo(titleLabel)
        }
    }
    
    //MARK: - UIMethods
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Constants.titleColor
        label.font = Constants.titleFont
        return label
    }
    
    private func makeSeeAllButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(Constants.buttonColor, for: .normal)
        button.titleLabel?.font = Constants.buttonFont
        button.addAction(UIAction { [weak self] _ in
            self?.buttonAction?()
        }, for: .touchUpInside)
        return button
    }
    
    // MARK: - Configuration
    
    func configuration(model: SectionHeaderModel) {
        titleLabel.text = model.title
        
        if let buttonTitle = model.buttonTitle {
            seeAllButton.setTitle(buttonTitle, for: .normal)
            buttonAction = model.buttonAction
            seeAllButton.isHidden = false
        } else {
            seeAllButton.isHidden = true
            buttonAction = nil
        }
    }
    
    //MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        seeAllButton.setTitle(nil, for: .normal)
        buttonAction = nil
    }
}

// MARK: - Constants

private extension AlbumsHeaderView {
    enum Constants {
        static let horizontalPadding: CGFloat = 16
        static let titleColor: UIColor = .black
        static let buttonColor: UIColor = .systemBlue
        static let titleFont: UIFont = .systemFont(ofSize: 22, weight: .bold)
        static let buttonFont: UIFont = .systemFont(ofSize: 16, weight: .medium)
    }
}
