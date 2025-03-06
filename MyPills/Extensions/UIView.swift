//
//  UIView.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 03.03.2025.
//

import UIKit

extension UIView {
    func applyShadow(
        cornerRadius: CGFloat = 8,
        shadowColor: UIColor = .black,
        shadowOffset: CGSize = CGSize(width: 0, height: 1),
        shadowOpacity: Float = 0.4,
        shadowRadius: CGFloat = 2.0
    ) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
    
    func animateIn() {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.alpha = 0

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = .identity
            self.alpha = 1
        }, completion: nil)
    }

    func animateOut(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.alpha = 0
        }) { _ in
            completion()
        }
    }
}
