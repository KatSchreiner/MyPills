//
//  DayButtonCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class NewPillStepThreeViewController: UIViewController {
    static var stepThree = "NewPillStepThreeCell"
    
    private lazy var dayButton: UIButton = {
        let dayButton = UIButton()
        dayButton.layer.cornerRadius = 20
        dayButton.backgroundColor = .lGray
        dayButton.setTitleColor(.gray, for: .normal)
        dayButton.addTarget(self, action: #selector(didTabDayButton), for: .touchUpInside)
        return dayButton
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .dGray
        label.text = "Напомнить"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        return timePicker
    }()
    
    private var isSelectedDay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        view.backgroundColor = .white
        
        [headerLabel, dayButton, timePicker].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            dayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dayButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dayButton.topAnchor.constraint(equalTo: view.topAnchor),
            dayButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            timePicker.topAnchor.constraint(equalTo: dayButton.bottomAnchor, constant: 20),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configure(title: String) {
        dayButton.setTitle(title, for: .normal)
    }
}

