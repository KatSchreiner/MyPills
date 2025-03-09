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

    private lazy var timePicker: CustomTimePicker = {
        let timePicker = CustomTimePicker()
        return timePicker
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    private let pickerData = ["Не зависит от еды", "До еды", "Во время еды", "После еды"]
    var selectedOption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white

        [timePicker, pickerView].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configurePicker()
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10),
            timePicker.trailingAnchor.constraint(equalTo: pickerView.leadingAnchor),
            timePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            timePicker.widthAnchor.constraint(equalToConstant: 150),
            timePicker.heightAnchor.constraint(equalToConstant: 60),

            pickerView.leadingAnchor.constraint(equalTo: timePicker.trailingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            pickerView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configurePicker() {
        pickerView.selectRow(0, inComponent: 0, animated: true)
        selectedOption = pickerData[0]
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
        label.font = UIFont.systemFont(ofSize: 17)
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
