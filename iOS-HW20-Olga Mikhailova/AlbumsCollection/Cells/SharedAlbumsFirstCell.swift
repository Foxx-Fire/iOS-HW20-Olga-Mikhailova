//
//   SharedAlbumsFirstCell.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 21.08.2025.
//

import SnapKit
import UIKit

class SharedAlbumsFirstCell: UICollectionViewCell {
    
    static let identifier = "SharedAlbumsFirstCell"
    
    // MARK: - Properties
    
    private var circles = [UIImageView]()
    
    // MARK: - UI Elements
    
    private lazy var circleContainer = makeCircleContainer()
    private lazy var descriptionLabel = makeDescriptionLabel()
    private lazy var subtitle = makesubtitleLabel()
    private lazy var stackView = makeStackView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createCircles()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR")
    }
    
    // MARK: - Setup
    
    private func createCircles() {
        for _ in 0..<4 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = Constants.circleSize / 2
            circles.append(imageView)
        }
    }
    
    private func setupHierarchy() {
        contentView.addSubview(circleContainer)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(subtitle)
        circles.forEach { circleContainer.addSubview($0) }
    }
    
    private func setupLayout() {
        setupCircleContainerConstraints()
        setupDescriptionLabelsConstraints()
        setupCirclesConstraints()
    }
    
    private func setupCircleContainerConstraints() {
        circleContainer.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(circleContainer.snp.width)
        }
    }
    
    private func setupDescriptionLabelsConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(circleContainer.snp.bottom).offset(Constants.stackTopOffset)
            make.leading.equalTo(circleContainer.snp.leading)
        }
    }
    
    private func setupCirclesConstraints() {
        // Центрируем всю группу кружков
        let groupView = UIView()
        circleContainer.addSubview(groupView)
        
        groupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(
                Constants.circleSize * 2 + Constants.circleHorizontalSpacing
            )
            make.height.equalTo(
                Constants.circleSize * 2 + Constants.circleVerticalSpacing
            )
        }
        
        // Располагаем кружки в сетке 2x2
        circles[0].snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(Constants.circleSize)
        }
        
        circles[1].snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(Constants.circleSize)
        }
        
        circles[2].snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview()
            make.size.equalTo(Constants.circleSize)
        }
        
        circles[3].snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview()
            make.size.equalTo(Constants.circleSize)
        }
    }
    
    // MARK: - UI Methods
    
    private func makeCircleContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = Constants.containerCornerRadius
        return view
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constants.descriptionFont
        label.textColor = Constants.descriptionColor
        return label
    }
    
    private func makeCircleImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.circleSize / 2
        return imageView
    }
    
    private func makesubtitleLabel() -> UILabel {
        let label = UILabel()
        label.font = Constants.descriptionFont
        label.textColor = Constants.descriptionColor
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
    
    func configuration(model: FirstSharedAlbum) {
        descriptionLabel.text = model.title
        subtitle.text = model.subtitle
        configureCircles(with: model.imageNames)
    }
    
    private func configureCircles(with imageName: [String]) {
        for (index, circle) in circles.enumerated() {
            if index < imageName.count {
                if let image = UIImage(named: imageName[index]) {
                    circle.image = image
                    circle.backgroundColor = .clear
                } else {
                    circle.image = UIImage(
                        systemName: Constants.placeholderSystemImageName
                    )
                    circle.backgroundColor = .systemGray5
                }
            }
        }
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCircles()
        descriptionLabel.text = nil
    }
    
    private func resetCircles() {
        circles.forEach { circle in
            circle.image = nil
            circle.backgroundColor = .systemGray5
        }
    }
}

// MARK: - Constants

extension SharedAlbumsFirstCell {
    enum Constants {
        static let circleSize: CGFloat = 80
        static let circleHorizontalSpacing: CGFloat = 16
        static let circleVerticalSpacing: CGFloat = 4
        static let containerCornerRadius: CGFloat = 8
        static let descriptionTopOffset: CGFloat = 7
        static let stackTopOffset: CGFloat = 8
        static let stackSpacing: CGFloat = 2
        static let descriptionColor: UIColor = .black
        static let descriptionFont: UIFont = .systemFont(ofSize: 14)
        static let placeholderSystemImageName = "person.circle.fill"
    }
}
