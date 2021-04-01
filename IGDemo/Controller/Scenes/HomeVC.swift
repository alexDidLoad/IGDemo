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
    
    private var posts = [Post]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchPosts()
    }
    
    //MARK: - API
    
    private func fetchPosts() {
        PostService.fetchPosts { [weak self] posts in
            guard let self = self else { return }
            
            self.posts = posts
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.reuseID)
        
        navigationItem.title             = "Instagram"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogout))
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    //MARK: - Selectors
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }
    
    
    @objc private func handleLogout() {
        do {
            try Auth.auth().signOut()
            let destVC = LoginVC()
            destVC.delegate = self.tabBarController as? MainTabBarController
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
        return posts.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.reuseID, for: indexPath) as! FeedCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
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
