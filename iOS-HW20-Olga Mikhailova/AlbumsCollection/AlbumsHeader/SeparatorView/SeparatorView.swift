//
//  SeparatorView.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 23.08.2025.
//

import SnapKit
import UIKit

class SectionSeparatorView: UICollectionReusableView {
    
    static let identifier = "SectionSeparatorView"
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(separatorView)
    }
    
    private func setupLayout() {
        separatorView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

