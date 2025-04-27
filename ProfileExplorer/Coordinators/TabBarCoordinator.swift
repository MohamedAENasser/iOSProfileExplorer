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
        
        tabBarController.viewControllers = []
        
        return tabBarController
    }
}
