//
//  DosageCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//
import UIKit

class DosageCell: UICollectionViewCell {

    lazy var titleTextField: ClearableTextField = {
        let textField = ClearableTextField()
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [titleTextField].forEach { contentView in
            self.contentView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleTextField.widthAnchor.constraint(equalToConstant: 200),
            titleTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(title: String) {
        
    }
}
