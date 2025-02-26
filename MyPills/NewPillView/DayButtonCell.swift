//
//  DayButtonCell.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 21.02.2025.
//

import UIKit

class DayButtonCell: UICollectionViewCell {
    lazy var dayButton: UIButton = {
        let dayButton = UIButton()
        dayButton.layer.cornerRadius = 20
        dayButton.backgroundColor = .lGray
        dayButton.setTitleColor(.gray, for: .normal)
        dayButton.addTarget(self, action: #selector(didTabDayButton), for: .touchUpInside)
        return dayButton
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
        contentView.addSubview(dayButton)
        dayButton.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            dayButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dayButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dayButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(title: String) {
        dayButton.setTitle(title, for: .normal)
    }
}

