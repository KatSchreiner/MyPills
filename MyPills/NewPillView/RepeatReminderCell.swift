//
//  RepeatReminderCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class RepeatReminderCell: UICollectionViewCell {
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .dGray
        label.text = "Напомнить"
        label.textAlignment = .left
        return label
    }()
    
    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        return timePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [headerLabel, timePicker].forEach { contentView in
            self.contentView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            timePicker.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 10),
            timePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            timePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            timePicker.widthAnchor.constraint(equalToConstant: 200),
            timePicker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

