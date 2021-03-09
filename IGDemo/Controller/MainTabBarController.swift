//
//  MainTabBarController.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/8/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - UIComponents
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
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
        
        let layout = UICollectionViewFlowLayout()
        
        let homeNav          = templateNavigationController(unselectedImage: SFSymbols.house, selectedImage: SFSymbols.houseFill, rootViewController: HomeVC(collectionViewLayout: layout))
        let searchNav        = templateNavigationController(unselectedImage: SFSymbols.search, selectedImage: SFSymbols.search, rootViewController: SearchVC())
        let imageSelectorNav = templateNavigationController(unselectedImage: SFSymbols.add, selectedImage: SFSymbols.addFill, rootViewController: ImageSelectorVC())
        let notificationNav  = templateNavigationController(unselectedImage: SFSymbols.heart, selectedImage: SFSymbols.heartFill, rootViewController: NotificationVC())
        let profileNav       = templateNavigationController(unselectedImage: SFSymbols.person, selectedImage: SFSymbols.personFill, rootViewController: ProfileVC())
        
        viewControllers  = [homeNav, searchNav, imageSelectorNav, notificationNav, profileNav]
        tabBar.tintColor = .black
    }
    
}
