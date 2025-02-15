//
//  WeeklyCalendarView.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 14.02.2025.
//

import UIKit

protocol WeeklyCalendarViewDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

class WeeklyCalendarView: UIView {
    // MARK: - Public Properties
    weak var delegate: WeeklyCalendarViewDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: "CalendarDayCell")
        return collectionView
    }()
    
    // MARK: - Private Properties
    private var dates: [Date] = []
    private var currentDate: Date = Date() {
        didSet {
            populateDates()
        }
    }
    
    // MARK: - Overrides Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func setupView() {
        [collectionView].forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
        populateDates()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func populateDates() {
        dates = Date.datesForWeekContaining(currentDate)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension WeeklyCalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCell", for: indexPath) as! CalendarDayCell
        let date = dates[indexPath.item]
        cell.configure(with: date)
        
        if Calendar.current.isDate(date, inSameDayAs: currentDate) {
            cell.backgroundColor = .dBlue
            cell.layer.cornerRadius = 10
            cell.dateLabel.textColor = .white
            cell.dayLabel.textColor = .white
        } else {
            cell.backgroundColor = .clear
            cell.dateLabel.textColor = .black
            cell.dayLabel.textColor = .black
        }
        
        return cell
    }
}

// MARK: – UICollectionViewDelegate
extension WeeklyCalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDate = dates[indexPath.item]
        delegate?.didSelectDate(selectedDate)
    }
}
// MARK: – UICollectionViewDelegateFlowLayout
extension WeeklyCalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: collectionView.frame.height)
    }
}
