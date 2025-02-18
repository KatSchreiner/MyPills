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
    private var currentDate: Date = Date()
    
    // MARK: - Overrides Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - IB Actions
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!
        } else if gesture.direction == .right {
            currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
        }
        populateDates()
    }

    // MARK: - Private Methods
    private func setupView() {
        [collectionView].forEach { view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraint()
        populateDates()
        addSwipeGestures()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func populateDates() {
        dates = Date.datesForWeek(from: currentDate)
        collectionView.reloadData()
    }
    
    private func addSwipeGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        collectionView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        collectionView.addGestureRecognizer(swipeRight)
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
        
        let today = Calendar.current.startOfDay(for: Date())
        
        if Calendar.current.isDate(date, inSameDayAs: today) {
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
        return CGSize(width: (collectionView.frame.width / 7), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
