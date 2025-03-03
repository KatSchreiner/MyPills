//
//  UnitPickerManager.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 03.03.2025.
//

import UIKit

class UnitPickerManager: UIView, UIPickerViewDelegate, UIPickerViewDataSource  {
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    private let unitPickerViewData = ["мл", "мг", "мкг", "г", "%", "мг/мл", "МЕ", "Капли", "Таблетки", "Капсулы"]
    var selectedUnit: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: self.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
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
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUnit = unitPickerViewData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
}
