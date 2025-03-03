//
//  IconSelectionViewController.swift
//  MyPills
//
//  Created by Екатерина Шрайнер on 26.02.2025.
//

import UIKit

class IconSelectionViewController: UIViewController {
    // MARK: - Public Properties
    var images: [UIImage?] = []
    private let imagesFormTypes = [UIImage(named: "capsule"), UIImage(named: "tablet"), UIImage(named: "drops"), UIImage(named: "syrup"), UIImage(named: "injection"), UIImage(named: "ointment"), UIImage(named: "spray"), UIImage(named: "nasalspray"), UIImage(named: "vitamins")]
    
    var selectedIcon: ((UIImage?) -> Void)?
    
    // MARK: - Private Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.minimumInteritemSpacing = 18
        layout.minimumLineSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: "IconCell")
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .lGray
        container.layer.cornerRadius = 16
        container.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        container.alpha = 0
        return container
    }()
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view == self.view {
            dismissContainer()
        }
    }
    
    // MARK: - Private Methods
    private func setupView() {
        view.backgroundColor = .clear
        
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint()
        
        startAnimationContainer()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
    }
    
    private func startAnimationContainer() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.container.transform = .identity
            self.container.alpha = 1
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }, completion: nil)
    }
    
    private func dismissContainer() {
        UIView.animate(withDuration: 0.5, animations: {
            self.container.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.container.alpha = 0
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        }) { _ in
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }

}

// MARK: - UICollectionViewDataSource
extension IconSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesFormTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as! IconCell
        cell.imageView.image = imagesFormTypes[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension IconSelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = imagesFormTypes[indexPath.item]
        
        UIView.animate(withDuration: 0.5, animations: {
            self.container.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.container.alpha = 0
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        }) { _ in
            self.selectedIcon?(selectedImage)
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}
