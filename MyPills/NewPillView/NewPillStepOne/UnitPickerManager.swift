//
//  UnitPickerManager.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 03.03.2025.
//

import UIKit

class UnitPickerManager: NSObject, UIPickerViewDataSource, UIPickerViewDelegate  {
    private let unitPickerViewData = ["мл", "мг", "мкг", "г", "%", "мг/мл", "МЕ", "Капли", "Таблетки", "Капсулы"]
    var selectedUnit: String?
    
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUnit = unitPickerViewData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        60
    }
}
