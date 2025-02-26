//
//  CustomTimePicker.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class CustomTimePicker: UIPickerView {
    private var hours: [String] = []
    private var minutes: [String] = []
            
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.delegate = self
        self.dataSource = self
        
        for hour in 0..<24 {
            hours.append(String(format: "%02d", hour))
        }
        
        for minute in 0..<60 {
            minutes.append(String(format: "%02d", minute))
        }
        
        setCurrentTime()
    }
    
    private func setCurrentTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        let currentMinute = calendar.component(.minute, from: currentDate)
        
        self.selectRow(currentHour, inComponent: 0, animated: true)
        self.selectRow(currentMinute, inComponent: 2, animated: true)
    }
}

extension CustomTimePicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hours.count
        } else if component == 1 {
            return 1
        } else {
            return minutes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        
        if component == 0 {
            label.text = hours[row]
        } else if component == 1 {
            label.text = ":"
        } else {
            label.text = minutes[row]
        }
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .dGray
        label.textAlignment = .center
        
        return label
    }
}

extension CustomTimePicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        60
    }
}
