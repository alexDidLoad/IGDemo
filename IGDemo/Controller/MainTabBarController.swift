//
//  MainTabBarController.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/8/21.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        checkIfUserIsLoggedIn()
    }
    
    //MARK: - Helpers
    
    private func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image         = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor  = .black
        return nav
    }
    
    
    private func configureViewControllers() {
        view.backgroundColor = .white
        
        let layout        = UICollectionViewFlowLayout()
        let profileLayout = UICollectionViewFlowLayout()
        
        let homeNav          = templateNavigationController(unselectedImage: SFSymbols.house, selectedImage: SFSymbols.houseFill, rootViewController: HomeVC(collectionViewLayout: layout))
        let searchNav        = templateNavigationController(unselectedImage: SFSymbols.search, selectedImage: SFSymbols.search, rootViewController: SearchVC())
        let imageSelectorNav = templateNavigationController(unselectedImage: SFSymbols.add, selectedImage: SFSymbols.addFill, rootViewController: ImageSelectorVC())
        let notificationNav  = templateNavigationController(unselectedImage: SFSymbols.heart, selectedImage: SFSymbols.heartFill, rootViewController: NotificationVC())
        
        let profileNav       = templateNavigationController(unselectedImage: SFSymbols.person, selectedImage: SFSymbols.personFill, rootViewController: ProfileVC(collectionViewLayout: profileLayout))
        
        viewControllers  = [homeNav, searchNav, imageSelectorNav, notificationNav, profileNav]
        tabBar.tintColor = .black
    }
    
    //MARK: - API
    
    private func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let destVC = LoginVC()
                let nav = UINavigationController(rootViewController: destVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
    
}
