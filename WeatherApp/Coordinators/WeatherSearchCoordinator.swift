//
//  WeatherSearchCoordinator.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import SwiftUI
import Combine

class WeatherSearchCoordinator: Coordinator {
    let viewModel = WeatherSearchViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    override func start() {
        viewController = UIHostingController(rootView: WeatherSearchView(viewModel: self.viewModel))
        setupNavAppearance()
        setupSubscription()
    }
    
    private func setupSubscription() {
        viewModel.selectedLocation.sink { [weak self] locationCellViewModel in
            let weatherCoordinator = WeatherCoordinator(lat: locationCellViewModel.lat, lon: locationCellViewModel.lon, navigationController: self!.navigationController, parent: self)
            weatherCoordinator.start()
            weatherCoordinator.delegate = self
        }.store(in: &subscriptions)
    }
    
    private func setupNavAppearance() {
        viewController.title = Constants.Search.weatherSearchViewTitle
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.sizeToFit()
        navigationController.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .thin),
            NSAttributedString.Key.foregroundColor: UIColor.primaryColor
        ]
    }
}

extension WeatherSearchCoordinator: CoordinatorDelegate {
    // Since UIKit is used for navigation, we need to
    // preemptively set the shared navigations nav bar's
    // title settings since the destination coordinator
    // has different settings
    func didFinish(coordinator: Coordinator) {
        navigationController.navigationBar.prefersLargeTitles = true
    }
}
