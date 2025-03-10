//
//  IntakeTimeCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class NewPillStepTwoViewController: UIViewController {
    static var stepTwo = "NewPillStepTwoCell"
    
    var pillData: PillModel?
    
    private lazy var timePickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Время приема"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .dGray
        return label
    }()
    
    private var timePickers: [CustomTimePicker] = []
    
    private lazy var addTimePickerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .lRed
        button.addTarget(self, action: #selector(didTapAddTimePicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private var pickerViewTopConstraint: NSLayoutConstraint?
    
    private let pickerData = ["Не зависит от еды", "До еды", "Во время еды", "После еды"]
    var selectedOption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addNewTimePicker()
    }
    
    @objc
    private func didTapAddTimePicker() {
        addNewTimePicker()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        [timePickerLabel, addTimePickerButton, pickerView].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configurePicker()
        addInitialConstraints()
    }
    
    private func addInitialConstraints() {
        NSLayoutConstraint.activate([
            timePickerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            timePickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            addTimePickerButton.centerYAnchor.constraint(equalTo: timePickerLabel.centerYAnchor),
            addTimePickerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        pickerViewTopConstraint = pickerView.topAnchor.constraint(equalTo: addTimePickerButton.bottomAnchor, constant: 20)
        pickerViewTopConstraint?.isActive = true
        
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    private func addNewTimePicker() {
        let newTimePicker = CustomTimePicker()
        timePickers.append(newTimePicker)
        
        view.addSubview(newTimePicker)
        newTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        let lastPicker: CustomTimePicker? = timePickers.count > 1 ? timePickers[timePickers.count - 2] : nil
        
        NSLayoutConstraint.activate([
            newTimePicker.topAnchor.constraint(equalTo: lastPicker?.bottomAnchor ?? addTimePickerButton.bottomAnchor, constant: 20),
            newTimePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newTimePicker.heightAnchor.constraint(equalToConstant: 60),
            newTimePicker.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        updatePickerViewConstraint()
    }
    
    private func configurePicker() {
        pickerView.selectRow(0, inComponent: 0, animated: true)
        selectedOption = pickerData[0]
    }
    
    private func updatePickerViewConstraint() {
        pickerViewTopConstraint?.isActive = false
        
        if let lastPicker = timePickers.last {
            pickerViewTopConstraint = pickerView.topAnchor.constraint(equalTo: lastPicker.bottomAnchor, constant: 20)
            pickerViewTopConstraint?.isActive = true
        }
        
        view.layoutIfNeeded()
    }
}

extension NewPillStepTwoViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .dGray
        label.textAlignment = .center
        label.text = pickerData[row]
        return label
    }
}

extension NewPillStepTwoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}
