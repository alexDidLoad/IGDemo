//
//  ProfileVC.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/8/21.
//

import UIKit


class ProfileVC: UICollectionViewController {
    
    //MARK: - Properties
    
    private var user: User
    private var posts = [Post]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        checkIfUserIsFollowed()
        fetchUserStats()
        fetchPosts()
    }
    
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API
    
    private func fetchPosts() {
        PostService.fetchPosts(forUser: user.uid) { [weak self] posts in
            guard let self = self else { return }
            
            self.posts = posts
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    private func fetchUserStats() {
        UserService.fetchUserStats(uid: user.uid) { [weak self] stats in
            guard let self = self else { return }
            self.user.stats = stats
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    
    private func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFollowed(uid: user.uid) { [weak self] isFollowed in
            guard let self = self else { return }
            self.user.isFollowing = isFollowed
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    
    //MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title            = user.username
        collectionView.dataSource       = self
        collectionView.delegate         = self
        collectionView.backgroundColor  = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseID)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeader.reuseID)
    }
    
    //MARK: - Selectors
    
}

//MARK: - UICollectionViewDataSource

extension ProfileVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseID, for: indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header       = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.reuseID, for: indexPath) as! ProfileHeader
        header.delegate  = self
        header.viewModel = ProfileHeaderViewModel(user: user)
        return header
    }
}

//MARK: - UICollectionViewDelegate

extension ProfileVC {
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}


//MARK: - ProfileHeaderDelegate

extension ProfileVC: ProfileHeaderDelegate {
   
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        if user.isCurrentUser {
        } else if user.isFollowing {
            UserService.unfollow(uid: user.uid) { [weak self] error in
                guard let self = self else { return }
                self.user.isFollowing = false
                DispatchQueue.main.async { self.collectionView.reloadData() }
            }
        } else {
            UserService.follow(uid: user.uid) { [weak self] error in
                guard let self = self else { return }
                self.user.isFollowing = true
                DispatchQueue.main.async { self.collectionView.reloadData() }
            }
        }
    }
    
}
