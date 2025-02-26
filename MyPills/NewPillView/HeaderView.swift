//
//  HeaderView.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class HeaderView: UICollectionReusableView {
    lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        headerLabel.textColor = .dGray
        headerLabel.textAlignment = .left
        return headerLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureCell(title: String) {
        headerLabel.text = title
    }
}

