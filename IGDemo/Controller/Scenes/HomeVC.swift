//
//  HomeVC.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/8/21.
//

import UIKit
import Firebase

class HomeVC: UICollectionViewController {
    
    //MARK: - UIComponents
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.reuseID)
        
        let attributes       = [ NSAttributedString.Key.font : UIFont(name: "Snell Roundhand Black", size: 24)!]
        navigationItem.title = "Instagram"

        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    //MARK: - Selectors
    
    @objc private func handleLogout() {
        do {
            try Auth.auth().signOut()
            let destVC = LoginVC()
            let nav = UINavigationController(rootViewController: destVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
}

//MARK: - UICollectionView

extension HomeVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.reuseID, for: indexPath) as! FeedCell
        
        return cell
    }
    
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
    
}
