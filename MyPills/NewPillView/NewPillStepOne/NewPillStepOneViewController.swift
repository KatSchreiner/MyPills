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
    
    var pillData: PillModel?
    
    let unitPickerViewData = ["мл", "мг", "мкг", "г", "%", "мг/мл", "МЕ", "Капля", "Таблетка", "Капсула", "Укол", "Пшик"]
    var selectedUnit: String?
    
    lazy var titleTextField: UITextField = createTextField()
    lazy var dosageTextField: UITextField = createTextField()
    
    lazy var unitPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var formTypesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        button.setImage(UIImage(named: "tablet"), for: .normal)
        button.addTarget(self, action: #selector(didTapFormTypesButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Properties
    private lazy var titleLabel: UILabel = createLabel(text: "Название", textColor: .black, fontSize: 18)
    private lazy var dosageLabel: UILabel = createLabel(text: "Дозировка", textColor: .black, fontSize: 18)
    
    private var iconSelectionVC = IconSelectionViewController()
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - IB Actions
    @objc
    private func didTapFormTypesButton() {
        let iconSelectionVC = IconSelectionViewController()

        iconSelectionVC.selectedIcon = { [weak self] selectedIcon in
            self?.formTypesButton.setImage(selectedIcon, for: .normal)
            self?.pillData?.selectedIcon = selectedIcon 
        }
        
        let navigationController = UINavigationController(rootViewController: iconSelectionVC)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        updateNextButtonState()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        titleTextField.text = pillData?.title
        dosageTextField.text = pillData?.dosage
        
        formTypesButton.setImage(UIImage(named: "tablet"), for: .normal)
        
        if let selectedIcon = pillData?.selectedIcon {
            formTypesButton.setImage(selectedIcon, for: .normal)
        }
        
        if let selectedUnit = pillData?.selectedUnit, let index = unitPickerViewData.firstIndex(of: selectedUnit) {
            unitPickerView.selectRow(index, inComponent: 0, animated: false)
        }
        
        [formTypesButton, titleLabel, titleTextField, dosageLabel, dosageTextField, unitPickerView].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            formTypesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formTypesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            titleLabel.topAnchor.constraint(equalTo: formTypesButton.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 60),

            dosageLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            dosageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            dosageTextField.topAnchor.constraint(equalTo: dosageLabel.bottomAnchor, constant: 10),
            dosageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dosageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dosageTextField.heightAnchor.constraint(equalToConstant: 60),

            unitPickerView.widthAnchor.constraint(equalToConstant: 180),
            unitPickerView.topAnchor.constraint(equalTo: dosageTextField.bottomAnchor),
            unitPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .lGray
        textField.textColor = .dGray
        textField.textAlignment = .left
        textField.delegate = self
        textField.isUserInteractionEnabled = true
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        textField.rightViewMode = .always
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }
    
    private func updateNextButtonState() {
        let isTitleFilled = !(titleTextField.text?.isEmpty ?? true)
        let isDosageFilled = !(dosageTextField.text?.isEmpty ?? true)
        let isEnabled = isTitleFilled && isDosageFilled
        
        if let addNewPillVC = parent as? AddNewPillViewController {
            addNewPillVC.nextButton.isEnabled = isEnabled
            addNewPillVC.nextButton.alpha = isEnabled ? 1.0 : 0.5
        }
    }
}

extension NewPillStepOneViewController: UIPickerViewDataSource {
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitPickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .dGray
        label.text = unitPickerViewData[row]
        return label
    }
}

// MARK: - UIPickerViewDelegate
extension NewPillStepOneViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUnit = unitPickerViewData[row]
        
        if let addNewPillVC = parent as? AddNewPillViewController {
            addNewPillVC.pillData.selectedUnit = selectedUnit
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}
