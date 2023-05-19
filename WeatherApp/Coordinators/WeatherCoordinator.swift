//
//  WeatherCoordinator.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/16/23.
//

import SwiftUI

class WeatherCoordinator: Coordinator {
    let weatherViewModel: WeatherViewModel
    
    init(lat: String, lon: String, navigationController: UINavigationController, parent: Coordinator?) {
        weatherViewModel = WeatherViewModel(lat: lat, lon: lon)
        super.init(navigationController: navigationController, parent: parent)
    }
    
    required init(navigationController: UINavigationController, parent: Coordinator?) {
        fatalError("init(navigationController:parent:) has not been implemented")
    }
    
    override func start() {
        viewController = UIHostingController(rootView: WeatherView(viewModel: self.weatherViewModel))
        setupNavAppearance()
    }
    
    private func setupNavAppearance() {
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.tintColor = .accent2
        navigationController.navigationBar.sizeToFit()
        navigationController.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .thin),
            NSAttributedString.Key.foregroundColor: UIColor.primaryColor
        ]
    }
}
