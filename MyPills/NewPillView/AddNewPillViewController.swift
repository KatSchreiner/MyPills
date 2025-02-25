//
//  AddNewPillViewController.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 20.02.2025.
//

import UIKit

final class AddNewPillViewController: UIViewController {

    // MARK: - Public Properties
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.register(TitleTextFieldCell.self, forCellWithReuseIdentifier: "TitleTextFieldCell")
        collectionView.register(DosageCell.self, forCellWithReuseIdentifier: "DosageCell")
        collectionView.register(IntakeMethodCell.self, forCellWithReuseIdentifier: "IntakeMethodCell")
        collectionView.register(DayButtonCell.self, forCellWithReuseIdentifier: "DayButtonCell")
        collectionView.register(IntakeTimeCell.self, forCellWithReuseIdentifier: "IntakeTimeCell")
        collectionView.register(RepeatReminderCell.self, forCellWithReuseIdentifier: "RepeatReminderCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    lazy var addPillButton: UIButton = {
        let addPillButton = UIButton()
        addPillButton.backgroundColor = .lBlue
        addPillButton.setTitle("Готово", for: .normal)
        addPillButton.layer.cornerRadius = 15
        addPillButton.addTarget(self, action: #selector(didTapAddNewPill), for: .touchUpInside)
        return addPillButton
    }()

    // MARK: - Private Properties

    private let intakeMethods = ["До еды", "Во время еды", "После еды", "Не зависит от еды"]
    private let daysOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]

    private var selectedIntakeMethod: String?
    private var selectedDays: [String] = []
    private var reminderTime: Date?

    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - IB Actions
    @objc
    private func didTapAddNewPill() {
        dismiss(animated: true)
    }

    // MARK: - Public Methods

    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .systemBackground

        [collectionView, addPillButton].forEach { [weak self] view in
            guard let self = self else { return }
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        addConstraint()
    }

    private func addConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: addPillButton.topAnchor, constant: -20),

            addPillButton.heightAnchor.constraint(equalToConstant: 60),
            addPillButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addPillButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addPillButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension AddNewPillViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionType(rawValue: section)! {
        case .title:
            return 1
        case .dosage:
            return 1
        case .intakeMethod:
            return 1
        case .intakeTime:
            return 1
        case .repeatDays:
            return daysOfWeek.count
        case .repeatReminder:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = SectionType(rawValue: indexPath.section) else { fatalError() }

        switch section {
        case .title:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleTextFieldCell", for: indexPath) as! TitleTextFieldCell
            cell.addNewPillViewController = self
            return cell

        case .dosage:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DosageCell", for: indexPath) as! DosageCell

            return cell

        case .intakeMethod:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntakeMethodCell", for: indexPath) as! IntakeMethodCell
            return cell

        case .intakeTime:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntakeTimeCell", for: indexPath) as! IntakeTimeCell
            return cell

        case .repeatDays:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayButtonCell", for: indexPath) as! DayButtonCell
            cell.configure(title: daysOfWeek[indexPath.row])
            return cell

        case .repeatReminder:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepeatReminderCell", for: indexPath) as! RepeatReminderCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {
            guard let section = SectionType(rawValue: indexPath.section) else { fatalError() }

            switch section {
            case .title, .repeatDays:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView

                switch section {
                case .repeatDays:
                    headerView.headerLabel.text = "Повторить"
                    
                case .title:
                    headerView.headerLabel.text = "Название"

                default:
                    break
                }

                return headerView
            default:
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let section = SectionType(rawValue: section) else { return CGSize.zero }

        switch section {
        case .dosage, .intakeMethod, .intakeTime, .repeatReminder:
            return CGSize.zero
        case .title, .repeatDays:
            return CGSize(width: collectionView.bounds.width, height: 30)
        }
    }
}

extension AddNewPillViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = SectionType(rawValue: indexPath.section) else { return }
        switch section {
        case .intakeMethod:
            break
        case .repeatDays:
            guard collectionView.cellForItem(at: indexPath) is DayButtonCell else { return }

        default:
            break
        }
    }
}

extension AddNewPillViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = SectionType(rawValue: indexPath.section) else { fatalError() }

            switch section {
            case .title:
                return CGSize(width: collectionView.bounds.width, height: 60)
            case .dosage:
                return CGSize(width: collectionView.bounds.width, height: 60)
            case .intakeMethod:
                return CGSize(width: collectionView.bounds.width, height: 60)
            case .intakeTime:
                return CGSize(width: collectionView.bounds.width, height: 60)
            case .repeatDays:
                return CGSize(width: (collectionView.bounds.width - 40) / 7, height: 40)
            case .repeatReminder:
                return CGSize(width: collectionView.bounds.width, height: 60)
            }
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let section = SectionType(rawValue: section) else { fatalError("Invalid section") }

        switch section {
        case .title:
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        case .dosage:
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        case .intakeMethod:
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        case .intakeTime:
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        case .repeatDays:
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        case .repeatReminder:
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        10
    }
}

