//
//  WeatherCardCell.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/16/23.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            AnimatedBackgroundView()
                .edgesIgnoringSafeArea(.bottom)
            mainContentView
        }
        .padding(.top, 10)
        .background(Color(.background))
    }
    
    @ViewBuilder
    var mainContentView: some View {
        switch viewModel.state {
        case .configured: weatherDetailView
        case .loading: loadingView
        case .error(let error): errorView(error)
        }
    }
    
    var weatherDetailView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 30) {
                WeatherHeaderView(viewModel: viewModel)
                WeatherStatsScrollView(viewModel: viewModel)
                HourlyForecastScrollView(viewModel: viewModel)
            }
            .padding(.top, 40)
            .padding(.bottom, 50)
        }
    }

    func errorView(_ error: Error) -> some View {
        ErrorView(title: Constants.Weather.errorTitle, error: URLError(.badServerResponse), reloadTapAction: { viewModel.refresh() })
            .padding(.top, 120)
    }
    
    var loadingView: some View {
        LoadingView()
            .padding(.top, 120)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(lat: "37.8045", lon: "-122.2714"))
    }
}
