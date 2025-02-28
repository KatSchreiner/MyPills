//
//  IntakeTimeCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class NewPillStepTwoCell: UICollectionViewCell {
    lazy var timePicker: CustomTimePicker = {
        let timePicker = CustomTimePicker()
        return timePicker
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    let pickerData = ["Не зависит от еды", "До еды", "Во время еды", "После еды"]
    var selectedOption: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [timePicker, pickerView].forEach { contentView in
            self.contentView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        configurePicker()
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            timePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            timePicker.trailingAnchor.constraint(equalTo: pickerView.leadingAnchor),
            timePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            timePicker.widthAnchor.constraint(equalToConstant: 150),
            timePicker.heightAnchor.constraint(equalToConstant: 60),

            pickerView.leadingAnchor.constraint(equalTo: timePicker.trailingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            pickerView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configurePicker() {
        pickerView.selectRow(0, inComponent: 0, animated: true)
        selectedOption = pickerData[0]
    }
}

extension NewPillStepTwoCell: UIPickerViewDataSource {
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

extension NewPillStepTwoCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}
