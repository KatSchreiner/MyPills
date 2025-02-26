//
//  FormTypesCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class FormTypesCell: UICollectionViewCell {
    private lazy var formTypesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.dGray, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var isSelectedForm: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(formTypesButton)
        formTypesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formTypesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            formTypesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            formTypesButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            formTypesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(title: String, image: UIImage?) {
        formTypesButton.setTitle(title, for: .normal)
        formTypesButton.setImage(image, for: .normal)
        
        formTypesButton.titleEdgeInsets = UIEdgeInsets(top: 25, left: -image!.size.width, bottom: 0, right: 0)
        formTypesButton.imageEdgeInsets = UIEdgeInsets(top: -image!.size.height, left: 0, bottom: 0, right: -title.size(withAttributes: [.font: formTypesButton.titleLabel!.font!]).width)
    }

    @objc private func buttonTapped() {
        toggleSelection()
    }
    
    private func toggleSelection() {
        isSelectedForm.toggle()
        
        if isSelectedForm {
            formTypesButton.setTitleColor(.dBlue, for: .normal)
            formTypesButton.layer.borderWidth = 2.0
            formTypesButton.layer.borderColor = UIColor.gray.cgColor
        } else {
            formTypesButton.setTitleColor(.dGray, for: .normal)
            formTypesButton.layer.borderWidth = 0
            formTypesButton.layer.borderColor = nil
        }
    }
}
