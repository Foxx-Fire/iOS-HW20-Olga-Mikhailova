//
//  NavigationBar.swift
//  iOS-HW20-Olga Mikhailova
//
//  Created by FoxxFire on 14.08.2025.
//

//import UIKit
//
//final class TallNavigationBar: UINavigationBar {
//    
//    // Высота навбара (можно регулировать при необходимости)
//    var customHeight: CGFloat = 140 {
//        didSet {
//            // Автоматически обновляем layout при изменении высоты
//            invalidateIntrinsicContentSize()
//            setNeedsLayout()
//        }
//    }
//    
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        CGSize(width: super.sizeThatFits(size).width, height: customHeight)
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        if let backgroundView = subviews.first(where: {
//            NSStringFromClass($0.classForCoder).contains("BarBackground")
//        }) {
//            backgroundView.frame.size.height = customHeight
//        }
//        
//    
//        subviews.forEach { subview in
//            if let scrollView = subview as? UIScrollView {
//                scrollView.contentInsetAdjustmentBehavior = .never
//            }
//        }
//    }
//    
//    //  Auto Layout
//    override var intrinsicContentSize: CGSize {
//        CGSize(width: UIView.noIntrinsicMetric, height: customHeight)
//    }
//}
