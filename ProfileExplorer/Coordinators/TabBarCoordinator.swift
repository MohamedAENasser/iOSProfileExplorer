//
//  TabBarCoordinator.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import UIKit

final class TabBarCoordinator {
    
    func start() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let profileVC = ProfileViewController()
        let adsVC = AdsViewController()
        let tagsVC = TagsViewController()
        
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        adsVC.tabBarItem = UITabBarItem(title: "Ads", image: UIImage(systemName: "megaphone"), tag: 1)
        tagsVC.tabBarItem = UITabBarItem(title: "Tags", image: UIImage(systemName: "tag"), tag: 2)
        
        tabBarController.viewControllers = [profileVC, adsVC, tagsVC]
        
        return tabBarController
    }
}
