//
//  AddNewPillViewController.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 20.02.2025.
//

import UIKit

final class AddNewPillViewController: UIViewController {

    // MARK: - Public Properties
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.backgroundColor = .lBlue
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.alpha = 0.4
        button.addTarget(self, action: #selector(goToNextStep), for: .touchUpInside)
        return button
    }()
    
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
        collectionView.register(NewPillStepOneCell.self, forCellWithReuseIdentifier: NewPillStepOneCell.stepOne)
        collectionView.register(NewPillStepTwoCell.self, forCellWithReuseIdentifier: NewPillStepTwoCell.stepTwo)
        collectionView.register(NewPillStepThreeCell.self, forCellWithReuseIdentifier: NewPillStepThreeCell.stepThree)
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

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .dBlue
        button.layer.cornerRadius = 8
        button.setTitle("Отмена", for: .normal)
        button.addTarget(self, action: #selector(didTapCancelNewPill), for: .touchUpInside)
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
        } else {
            goToNextStep()
        }
    }
    
    @objc
    private func didTapCancelNewPill() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func goToPreviousStep() {
        guard let currentIndex = SectionType.allCases.firstIndex(of: currentStep), currentIndex > 0 else { return }
        
        currentStep = SectionType.allCases[currentIndex - 1]
        updateUI(for: currentStep)
    }
    
    @objc
    private func goToNextStep() {
        guard validateCurrentStep() else { return }
        
        guard let currentIndex = SectionType.allCases.firstIndex(of: currentStep),
              currentIndex < SectionType.allCases.count - 1 else { return }

        currentStep = SectionType.allCases[currentIndex + 1]
        updateUI(for: currentStep)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Public Methods

    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        [collectionView, progressView, backButton, nextButton, cancelButton].forEach { [weak self] view in
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
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalToConstant: 150),
            cancelButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func updateUI(for step: SectionType) {
        collectionView.reloadData()
                
        backButton.isHidden = currentStep == SectionType.allCases.first
        nextButton.isHidden = currentStep == SectionType.allCases.last
        addPillButton.isHidden = currentStep != SectionType.allCases.last
        cancelButton.isHidden = currentStep != SectionType.allCases.first
        
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

// MARK: - UICollectionViewDataSource
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewPillStepOneCell.stepOne, for: indexPath) as! NewPillStepOneCell
            cell.delegate = self
            cell.titleTextField.delegate = self
            cell.dosageTextField.delegate = self
            return cell
            
        case .intakeTime:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewPillStepTwoCell.stepTwo, for: indexPath) as! NewPillStepTwoCell
            return cell
            
        case .repeatDays:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewPillStepThreeCell.stepThree, for: indexPath) as! NewPillStepThreeCell
            cell.configure(title: daysOfWeek[indexPath.row])
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension AddNewPillViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch currentStep {
        case .title:
            let cell = collectionView.cellForItem(at: indexPath) as? NewPillStepOneCell
            
        case .intakeTime:
            let cell = collectionView.cellForItem(at: indexPath) as? NewPillStepTwoCell
        
        case .repeatDays:
            guard collectionView.cellForItem(at: indexPath) is NewPillStepThreeCell else { return }
        }
    }
    
    private func showFormTypesSelection(for cell: NewPillStepOneCell) {
        let iconSelectionVC = IconSelectionViewController()
        iconSelectionVC.selectedIcon = { [weak cell] selectedImage in
            guard let cell = cell else { return }
            print("Icon selected for cell")
            UIView.transition(with: cell.formTypesButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                cell.formTypesButton.setImage(selectedImage, for: .normal)
            }, completion: nil)
        }
        
        addChild(iconSelectionVC)
        view.addSubview(iconSelectionVC.view)
        iconSelectionVC.view.frame = view.bounds
        iconSelectionVC.didMove(toParent: self)
        print("IconSelectionViewController added")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AddNewPillViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        
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

// MARK: - AddNewPillViewController
extension AddNewPillViewController {
    private func validateCurrentStep() -> Bool {
        switch currentStep {
        case .title:
            if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? NewPillStepOneCell {
                let isTitleFilled = !(cell.titleTextField.text?.isEmpty ?? true)
                let isDosageFilled = !(cell.dosageTextField.text?.isEmpty ?? true)
                
                return isTitleFilled && isDosageFilled
            }
            return false
            
        case .intakeTime:
            // TODO: логика проверки intakeTime
            return true
            
        case .repeatDays:
            // TODO: логика проверки repeatDays
            return true
        }
    }
}

// MARK: - NewPillStepOneCellDelegate
extension AddNewPillViewController: NewPillStepOneCellDelegate {
    func didChangeTextFields(in cell: NewPillStepOneCell) {
        let isValid = validateCurrentStep()
        nextButton.isEnabled = isValid
        nextButton.alpha = isValid ? 1.0 : 0.4
    }
    
    func didTapFormTypesButton(in cell: NewPillStepOneCell) {
        showFormTypesSelection(for: cell)
    }
}

// MARK: - NewPillStepOneCellDelegate
extension AddNewPillViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
