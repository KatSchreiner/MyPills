//
//  NewPillViewCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 20.02.2025.
//

import UIKit

class NewPillStepOneCell: UICollectionViewCell, UITextFieldDelegate {
    // MARK: - Public Properties
    weak var addNewPillViewController: AddNewPillViewController?

    // MARK: - Private Properties
    private lazy var formTypesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        button.addTarget(self, action: #selector(didTapFormTypesButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Название"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var titleTextField: ClearableTextField = {
        let textField = ClearableTextField()
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var dosageTextField: ClearableTextField = {
        let textField = ClearableTextField()
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var dosageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Дозировка"
        label.textAlignment = .left
        return label
    }()
        
    private let imagesFormTypes = [
        UIImage(named: "capsule"),
        UIImage(named: "tablet"),
        UIImage(named: "drops"),
        UIImage(named: "syrup"),
        UIImage(named: "injection"),
        UIImage(named: "ointment"),
        UIImage(named: "spray"),
        UIImage(named: "nasalspray"),
        UIImage(named: "vitamins")
    ]
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IB Actions
    @objc
    private func didTapFormTypesButton() {
        showFormTypesSelection()
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        let isTitleFilled = !(titleTextField.text?.isEmpty ?? true)
        let isDosageFilled = !(dosageTextField.text?.isEmpty ?? true)
        
        if isTitleFilled && isDosageFilled {
            addNewPillViewController?.nextButton.isEnabled = true
            addNewPillViewController?.nextButton.alpha = 1.0
        } else {
            addNewPillViewController?.nextButton.isEnabled = false
            addNewPillViewController?.nextButton.alpha = 0.4
        }
    }
    
    // MARK: - Public Methods

    
    // MARK: - Private Methods
    private func setupView() {
        [titleTextField, formTypesButton, dosageTextField, titleLabel, dosageLabel].forEach { contentView in
            self.contentView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        if let tabletImage = imagesFormTypes[1] {
            formTypesButton.setImage(tabletImage, for: .normal)
        }
        
        addConstraint()
        setupTapGesture()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            formTypesButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            formTypesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            formTypesButton.widthAnchor.constraint(equalToConstant: 100),
            formTypesButton.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: formTypesButton.bottomAnchor, constant: 30),

            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            titleTextField.heightAnchor.constraint(equalToConstant: 60),
            
            dosageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dosageLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
            
            dosageTextField.topAnchor.constraint(equalTo: dosageLabel.bottomAnchor, constant: 20),
            dosageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dosageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dosageTextField.heightAnchor.constraint(equalToConstant: 60),
            dosageTextField.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    private func showFormTypesSelection() {
        let iconSelectionVC = IconSelectionViewController()
        iconSelectionVC.images = imagesFormTypes
        iconSelectionVC.selectedIcon = { [weak self] image in
            guard let self = self else { return }
            
            UIView.transition(with: self.formTypesButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.formTypesButton.setImage(image, for: .normal)
            }, completion: nil)
            
            self.dismissIconSelection()
        }
        
        addNewPillViewController?.addChild(iconSelectionVC)
        addNewPillViewController?.view.addSubview(iconSelectionVC.view)
        iconSelectionVC.view.frame = addNewPillViewController!.view.bounds
        iconSelectionVC.didMove(toParent: addNewPillViewController)
    }

    private func dismissIconSelection() {
        if let iconSelectionVC = addNewPillViewController?.children.last {
            iconSelectionVC.willMove(toParent: nil)
            iconSelectionVC.view.removeFromSuperview()
            iconSelectionVC.removeFromParent()
        }
    }
    
    private func setupTapGesture() {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
        self.contentView.isUserInteractionEnabled = true
    }

    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        self.endEditing(true)
    }
}
