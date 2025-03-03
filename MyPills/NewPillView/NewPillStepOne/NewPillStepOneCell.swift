//
//  NewPillViewCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 20.02.2025.
//

import UIKit

protocol NewPillStepOneCellDelegate: AnyObject {
    func didTapFormTypesButton(in cell: NewPillStepOneCell)
    func didChangeTextFields(in cell: NewPillStepOneCell)
}
class NewPillStepOneCell: UICollectionViewCell, UITextFieldDelegate {
    // MARK: - Public Properties
    
    static let stepOne = "NewPillStepOneCell"
    weak var delegate: NewPillStepOneCellDelegate?
    
    lazy var formTypesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        button.addTarget(self, action: #selector(didTapFormTypesButton), for: .touchUpInside)
        return button
    }()
    
    lazy var titleTextField: ClearableTextField = {
        let textField = ClearableTextField()
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var dosageTextField: ClearableTextField = {
        let textField = ClearableTextField()
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    // MARK: - Private Properties
    private let unitPickerManager = UnitPickerManager()

    private lazy var titleLabel: UILabel = {
        return createLabel(text: "Название", textColor: .black, fontSize: 18)
    }()
    
    private lazy var dosageLabel: UILabel = {
        return createLabel(text: "Дозировка", textColor: .black, fontSize: 18)
    }()
    
    private lazy var unitPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = unitPickerManager
        pickerView.dataSource = unitPickerManager
        return pickerView
    }()
        
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
        delegate?.didTapFormTypesButton(in: self)
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        delegate?.didChangeTextFields(in: self)
    }
    
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        self.endEditing(true)
    }

    // MARK: - Private Methods
    private func setupView() {
        [titleTextField, formTypesButton, dosageTextField, titleLabel, dosageLabel, unitPickerView].forEach { contentView in
            self.contentView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
        }
        self.contentView.clipsToBounds = false

        if let tabletImage = UIImage(named: "tablet") {
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
            dosageTextField.heightAnchor.constraint(equalToConstant: 60),
            dosageTextField.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
            unitPickerView.widthAnchor.constraint(equalToConstant: 150),
            unitPickerView.leadingAnchor.constraint(equalTo: dosageTextField.trailingAnchor, constant: 16),
            unitPickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            unitPickerView.centerYAnchor.constraint(equalTo: dosageTextField.centerYAnchor)
        ])
    }
    
    private func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
        self.contentView.isUserInteractionEnabled = true
    }
    
    private func createLabel(text: String, textColor: UIColor, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = text
        label.textColor = textColor
        label.textAlignment = .left
        return label
    }
}
