//
//  WeatherHeaderView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/18/23.
//

import SwiftUI

struct WeatherHeaderView: View {
    let viewModel: WeatherViewModel
    
    var body: some View {
        VStack(spacing: 40) {
            titleHeader
            temperatureView
                .padding(.bottom, 40)
        }
    }
    
    var titleHeader: some View {
        VStack(spacing: 8) {
            Text(viewModel.city)
                .foregroundColor(.white)
                .font(.system(size: 35, weight: .semibold))
            
            VStack(spacing: 0) {
                Text(viewModel.weatherDescription.capitalized)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                HStack(spacing: 8){
                    HStack(spacing: 0) {
                        Image(systemName: "arrow.up")
                        Text(viewModel.highTemp)
                    }
                    HStack(spacing: 0) {
                        Image(systemName: "arrow.down")
                        Text(viewModel.lowTemp)
                    }
                }
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
            }
        }
    }
    
    var temperatureView: some View {
        Text(viewModel.degrees)
            .foregroundColor(Color(.white))
            .font(.system(size: 90, weight: .heavy))
            .padding(.vertical)
            .padding(.horizontal, 30)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .overlay {
                forecastIcon
                    .offset(x: 100, y: -65)
            }
            .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 3)
    }
    
    @ViewBuilder
    var forecastIcon: some View {
        if let url = viewModel.iconURL {
            CachedImageView(url: url) { phase in
                switch phase {
                case .empty:
                    EmptyView()
                case .failure:
                    // Let silently fail here
                    EmptyView()
                case .success(let image):
                    generateImage(image: image.resizable())
                default:
                    generateImage(image: Image(systemName:"cloud.fill"))
                }
            }
        }
    }
    
    func generateImage(image: Image) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 140, height: 140)
            .background(.clear)
            .shadow(color: .black.opacity(0.3), radius: 8, x: 10, y: 10)
    }
}

struct WeatherHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.accent2)
            WeatherHeaderView(viewModel: WeatherViewModel(lat: "37.8045", lon: "-122.2714"))
        }
    }
}
