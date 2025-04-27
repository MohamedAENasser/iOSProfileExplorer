//
//  AppCoordinator.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let tabBarCoordinator: TabBarCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.tabBarCoordinator = TabBarCoordinator()
    }
    
    func start() {
        window.rootViewController = tabBarCoordinator.start()
        window.makeKeyAndVisible()
    }
}
