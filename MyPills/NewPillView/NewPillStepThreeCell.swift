//
//  DayButtonCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class NewPillStepThreeCell: UICollectionViewCell {
    lazy var dayButton: UIButton = {
        let dayButton = UIButton()
        dayButton.layer.cornerRadius = 20
        dayButton.backgroundColor = .lGray
        dayButton.setTitleColor(.gray, for: .normal)
        dayButton.addTarget(self, action: #selector(didTabDayButton), for: .touchUpInside)
        return dayButton
    }()
    
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
    
    private var isSelectedDay: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTabDayButton() {
        isSelectedDay.toggle()
        
        if isSelectedDay {
            dayButton.backgroundColor = .dBlue
            dayButton.setTitleColor(.lGray, for: .normal)
        } else {
            dayButton.backgroundColor = .lGray
            dayButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    private func setupView() {
        [headerLabel, dayButton, timePicker].forEach { contentView in
            self.contentView.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            dayButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dayButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dayButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            timePicker.topAnchor.constraint(equalTo: dayButton.bottomAnchor, constant: 20),
            timePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            timePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            timePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(title: String) {
        dayButton.setTitle(title, for: .normal)
    }
}

