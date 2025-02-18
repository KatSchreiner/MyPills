//
//  ViewController.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 13.02.2025.
//

import UIKit

class MyPillsViewController: UIViewController {
    // MARK: - Public Properties
    lazy var weeklyCalendarView: WeeklyCalendarView = {
        let view = WeeklyCalendarView()
        return view
    }()
    
    lazy var addPillButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.backgroundColor = .lBlue
        button.tintColor = .white
        button.layer.cornerRadius = 40
        button.addTarget(self, action: #selector(didTapAddPillButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Private Properties
    private var selectedDate: Date = Date()
        
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
            
    // MARK: - IB Actions
    @objc
    private func didTapAddPillButton() {
        
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        weeklyCalendarView.delegate = self
        
        [weeklyCalendarView, addPillButton].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            weeklyCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weeklyCalendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weeklyCalendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weeklyCalendarView.heightAnchor.constraint(equalToConstant: 70),
            weeklyCalendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addPillButton.widthAnchor.constraint(equalToConstant: 80),
            addPillButton.heightAnchor.constraint(equalToConstant: 80),
            addPillButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addPillButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - WeeklyCalendarViewDelegate
extension MyPillsViewController: WeeklyCalendarViewDelegate {
    func didSelectDate(_ date: Date) {
        selectedDate = date
    }
}

// MARK: - UITableViewDataSource

// MARK: – UITableViewDelegate

// MARK: - UICollectionViewDataSource

// MARK: – UICollectionViewDelegate
