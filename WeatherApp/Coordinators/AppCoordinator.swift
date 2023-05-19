//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow?
    init(scene: UIScene) {
        super.init(navigationController: UINavigationController(), parent: nil)
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
            
    required init(navigationController: UINavigationController, parent: Coordinator?) {
        fatalError("init(navigationController:parent:) has not been implemented")
    }
    
    override func start() {
        // Typical app entry point. Navigation logic would go here
        // Since there is no other screens, lets just go to the weather search screen
        let weatherSearchCoordinator = WeatherSearchCoordinator(navigationController: navigationController, parent: self)
        weatherSearchCoordinator.start()
    }
}
