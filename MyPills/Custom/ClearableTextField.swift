//
//  ClearableTextField.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 26.02.2025.
//

import UIKit

class ClearableTextField: UITextField {
    private lazy var  clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage((UIImage(systemName: "xmark.circle.fill")), for: .normal)
        button.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        button.tintColor = .lightGray
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func clearText() {
        self.text = ""
    }
    
    private func setup() {
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 2.0
        
        self.backgroundColor = .lGray
        self.textColor = .dGray
        self.alpha = 0.3
        self.textAlignment = .left
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        self.leftView = leftPadding
        self.leftViewMode = .always
    }
}
