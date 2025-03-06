//
//  NewPillViewCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 20.02.2025.
//

import UIKit

class NewPillStepOneViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Public Properties
    static let stepOne = "NewPillStepOneCell"

    lazy var formTypesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        button.adjustsImageWhenHighlighted = false
        button.setImage(UIImage(named: "tablet"), for: .normal)
        button.addTarget(self, action: #selector(didTapFormTypesButton), for: .touchUpInside)
        return button
    }()
    
    lazy var titleTextField: ClearableTextField = createTextField()
    lazy var dosageTextField: ClearableTextField = createTextField()
    
    // MARK: - Private Properties
    private lazy var titleLabel: UILabel = createLabel(text: "Название", textColor: .black, fontSize: 18)
    private lazy var dosageLabel: UILabel = createLabel(text: "Дозировка", textColor: .black, fontSize: 18)
    
    private lazy var unitPickerView: UnitPickerManager = {
        let pickerView = UnitPickerManager()
        return pickerView
    }()
    
    private var iconSelectionVC: IconSelectionViewController?
        
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - IB Actions
    @objc
    private func didTapFormTypesButton() {
        iconSelectionVC = IconSelectionViewController()
        iconSelectionVC?.selectedIcon = { [weak self] selectedImage in
            guard let self = self else { return }

            UIView.transition(with: self.formTypesButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.formTypesButton.setImage(selectedImage, for: .normal)
            }, completion: nil)
        }
        
        guard let iconSelectionVC = iconSelectionVC else { return }
        
        addChild(iconSelectionVC)
        view.addSubview(iconSelectionVC.view)
        iconSelectionVC.view.frame = view.bounds
        iconSelectionVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        iconSelectionVC.startAnimationContainer()
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {

    }
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .white
        
        [titleTextField, formTypesButton, dosageTextField, titleLabel, dosageLabel, unitPickerView].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        self.view.clipsToBounds = false
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            formTypesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formTypesButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            formTypesButton.widthAnchor.constraint(equalToConstant: 100),
            formTypesButton.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: formTypesButton.bottomAnchor, constant: 16),

            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            titleTextField.heightAnchor.constraint(equalToConstant: 60),
            
            dosageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dosageLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            
            dosageTextField.topAnchor.constraint(equalTo: dosageLabel.bottomAnchor, constant: 16),
            dosageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dosageTextField.heightAnchor.constraint(equalToConstant: 60),
            dosageTextField.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            
            unitPickerView.widthAnchor.constraint(equalToConstant: 150),
            unitPickerView.leadingAnchor.constraint(equalTo: dosageTextField.trailingAnchor, constant: 16),
            unitPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            unitPickerView.centerYAnchor.constraint(equalTo: dosageTextField.centerYAnchor)
        ])
    }
    
    private func createLabel(text: String, textColor: UIColor, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = text
        label.textColor = textColor
        label.textAlignment = .left
        return label
    }
    
    private func createTextField() -> ClearableTextField {
        let textField = ClearableTextField()
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }
}
