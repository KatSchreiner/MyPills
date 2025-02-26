//
//  NewPillViewCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 20.02.2025.
//

import UIKit

class TitleTextFieldCell: UICollectionViewCell {
    lazy var titleTextField: ClearableTextField = {
        let textField = ClearableTextField()
        return textField
    }()
    
    private lazy var formTypesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lGray
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        button.addTarget(self, action: #selector(didTapFormTypesButton), for: .touchUpInside)
        button.addTarget(self, action: #selector(animateButtonDown), for: .touchDown) 
        button.addTarget(self, action: #selector(animateButtonUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return button
    }()
    
    weak var addNewPillViewController: AddNewPillViewController?
    
    private let imagesFormTypes = [
        UIImage(named: "capsule"),
        UIImage(named: "tablet"),
        UIImage(named: "drops"),
        UIImage(named: "syrup"),
        UIImage(named: "injection"),
        UIImage(named: "ointment")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapFormTypesButton() {
        showFormTypesSelection()
    }
    
    @objc
    private func animateButtonDown(sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.alpha = 0.3
        })
    }

    @objc
    private func animateButtonUp(sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.alpha = 1.0
        })
    }
    
    @objc
    private func clearText() {
        titleTextField.text = ""
    }
    
    private func setupView() {
        [titleTextField, formTypesButton].forEach { contentView in
            self.contentView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: formTypesButton.leadingAnchor, constant: -10),
            titleTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            formTypesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            formTypesButton.leadingAnchor.constraint(equalTo: titleTextField.trailingAnchor, constant: 10),
            formTypesButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            formTypesButton.widthAnchor.constraint(equalToConstant: 60),
            formTypesButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    func configure(title: String, image: UIImage?) {
        formTypesButton.setImage(image, for: .normal)
        
        formTypesButton.imageEdgeInsets = UIEdgeInsets(top: -image!.size.height, left: 0, bottom: 0, right: -title.size(withAttributes: [.font: formTypesButton.titleLabel!.font!]).width)
    }
    
    private func showFormTypesSelection() {
        let alertController = UIAlertController(title: "Выберите иконку для Вашего лекарства", message: nil, preferredStyle: .alert)
        
        for (index, image) in imagesFormTypes.enumerated() {
            let action = UIAlertAction(title: "", style: .default) { [weak self] _ in
                self?.formTypesButton.setImage(image, for: .normal)
            }
            
            action.setValue(image?.withRenderingMode(.alwaysOriginal), forKey: "image")
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        addNewPillViewController?.present(alertController, animated: true)
    }
}
