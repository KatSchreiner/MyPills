//
//  AddNewPillViewController.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 20.02.2025.
//

import UIKit

final class AddNewPillViewController: UIViewController {

    // MARK: - Public Properties

    // MARK: - Private Properties
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .lBlue
        progressView.trackTintColor = .lGray
        return progressView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(NewPillStepOneCell.self, forCellWithReuseIdentifier: "NewPillStepOneCell")
        collectionView.register(NewPillStepThreeCell.self, forCellWithReuseIdentifier: "NewPillStepThreeCell")
        collectionView.register(NewPillStepTwoCell.self, forCellWithReuseIdentifier: "NewPillStepTwoCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var addPillButton: UIButton = {
        let addPillButton = UIButton()
        addPillButton.backgroundColor = .dBlue
        addPillButton.setTitle("Готово", for: .normal)
        addPillButton.layer.cornerRadius = 8
        addPillButton.addTarget(self, action: #selector(didTapAddNewPill), for: .touchUpInside)
        return addPillButton
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Назад", for: .normal)
        button.backgroundColor = .lBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(goToPreviousStep), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.backgroundColor = .lBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(goToNextStep), for: .touchUpInside)
        return button
    }()
    
    private var currentStep: SectionType = .title
    
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
        if currentStep == .repeatDays {
            // TODO: Сохранить данные
            dismiss(animated: true)
        } else {
            goToNextStep()
        }
    }
    
    @objc
    private func goToPreviousStep() {
        guard let currentIndex = SectionType.allCases.firstIndex(of: currentStep), currentIndex > 0 else { return }
        
        currentStep = SectionType.allCases[currentIndex - 1]
        updateUI(for: currentStep)
    }
    
    @objc
    private func goToNextStep() {
        guard let currentIndex = SectionType.allCases.firstIndex(of: currentStep),
              currentIndex < SectionType.allCases.count - 1 else { return }

        currentStep = SectionType.allCases[currentIndex + 1]
        updateUI(for: currentStep)
    }

    // MARK: - Public Methods

    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        [collectionView, progressView, backButton, nextButton].forEach { [weak self] view in
            guard let self = self else { return }
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        updateUI(for: currentStep)
        addConstraint()
    }

    private func addConstraint() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.heightAnchor.constraint(equalToConstant: 60),

            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func updateUI(for step: SectionType) {
        collectionView.reloadData()
                
        backButton.isHidden = currentStep == SectionType.allCases.first
        nextButton.isHidden = currentStep == SectionType.allCases.last
        addPillButton.isHidden = currentStep != SectionType.allCases.last
        
        if currentStep == SectionType.allCases.last {
            view.addSubview(addPillButton)
            addPillButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                addPillButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                addPillButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                addPillButton.widthAnchor.constraint(equalToConstant: 150),
                addPillButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        } else {
            addPillButton.removeFromSuperview()
        }
        
        updateProgress()
    }
    
    private func updateProgress() {
        let totalSteps = Float(SectionType.allCases.count)
        let currentStepIndex = Float(currentStep.rawValue)
        
        progressView.setProgress((currentStepIndex + 1) / totalSteps, animated: true)
    }
}

extension AddNewPillViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentStep {
        case .title: return 1
        case .intakeTime: return 1
        case .repeatDays: return daysOfWeek.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch currentStep {
        case .title:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewPillStepOneCell", for: indexPath) as! NewPillStepOneCell
            cell.addNewPillViewController = self
            return cell
            
        case .intakeTime:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewPillStepTwoCell", for: indexPath) as! NewPillStepTwoCell
            return cell
            
        case .repeatDays:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewPillStepThreeCell", for: indexPath) as! NewPillStepThreeCell
            cell.configure(title: daysOfWeek[indexPath.row])
            return cell
        }
    }
}

extension AddNewPillViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch currentStep {
        case .repeatDays:
            guard collectionView.cellForItem(at: indexPath) is NewPillStepThreeCell else { return }
            
        default:
            break
        }
    }
}

extension AddNewPillViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        switch currentStep {
        case .title:
            return CGSize(width: width, height: collectionView.bounds.height)
            
        case .intakeTime:
            return CGSize(width: width, height: 60)
            
        case .repeatDays:
            return CGSize(width: (width - 40) / 7, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = collectionView.bounds.width
        
        switch currentStep {
        case .title:
            return UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0)
            
        case .intakeTime:
            return UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0)
            
        case .repeatDays:
            return UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0)
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
