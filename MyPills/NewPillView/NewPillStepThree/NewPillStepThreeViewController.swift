//
//  DayButtonCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class NewPillStepThreeViewController: UIViewController {
    static var stepThree = "NewPillStepThreeCell"
    
    private lazy var repeatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .dGray
        label.text = "Повторить"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dayButtons: [UIButton] = []
    private let daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    private var selectedDays: Set<Int> = []
    
    private lazy var dayButtonStackView: UIStackView = {
        let dayButtonStackView = UIStackView()
        dayButtonStackView.axis = .horizontal
        dayButtonStackView.distribution = .fillEqually
        dayButtonStackView.spacing = 10
        
        for (index, day) in daysOfWeek.enumerated() {
            let button = UIButton()
            button.layer.cornerRadius = 20
            button.backgroundColor = .lGray
            button.setTitle(day, for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(didTapDayButton), for: .touchUpInside)
            dayButtons.append(button)
            dayButtonStackView.addArrangedSubview(button)
        }
        
        return dayButtonStackView
    }()
    
    private lazy var reminderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .dGray
        label.text = "Напомнить?"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var reminderSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = false
        switchControl.addTarget(self, action: #selector(didToggleReminderSwitch), for: .valueChanged)
        return switchControl
    }()
    
    private lazy var reminderStackView: UIStackView = {
        let reminderStackView = UIStackView(arrangedSubviews: [reminderLabel, reminderSwitch])
        reminderStackView.axis = .horizontal
        reminderStackView.spacing = 20
        return reminderStackView
    }()
    
    private var isReminderEnabled: Bool = false
    private var isSelectedDay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc
    private func didTapDayButton(sender: UIButton) {
        let index = sender.tag
        if selectedDays.contains(index) {
            selectedDays.remove(index)
            sender.backgroundColor = .lGray
            sender.setTitleColor(.gray, for: .normal)
        } else {
            selectedDays.insert(index)
            sender.backgroundColor = .dBlue
            sender.setTitleColor(.lGray, for: .normal)
        }
    }
    
    @objc
    private func didToggleReminderSwitch(sender: UISwitch) {
        isReminderEnabled = sender.isOn
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        [repeatLabel, dayButtonStackView, reminderStackView].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            repeatLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            repeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            dayButtonStackView.topAnchor.constraint(equalTo: repeatLabel.bottomAnchor, constant: 20),
            dayButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dayButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dayButtonStackView.heightAnchor.constraint(equalToConstant: 40),
            dayButtonStackView.widthAnchor.constraint(equalToConstant: 50),
            
            reminderStackView.topAnchor.constraint(equalTo: dayButtonStackView.bottomAnchor, constant: 30),
            reminderStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
