//
//  WeatherStatsScrollView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/19/23.
//

import SwiftUI

struct WeatherStatsScrollView: View {
    let viewModel: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.Weather.dayDetailsTitle)
                .font(.system(size: 15, weight: .light))
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Divider()
                .frame(height: 0.5)
                .overlay(Color(.white))
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    WeatherStatsDetailCell(systemImage: "sunrise.fill", value: viewModel.sunrise)
                    WeatherStatsDetailCell(systemImage: "sunset.fill", value: viewModel.sunset)
                    WeatherStatsDetailCell(systemImage: "wind", value: viewModel.windSpeed)
                    WeatherStatsDetailCell(systemImage: "humidity.fill", value: viewModel.humidity)
                }
                .padding()
            }
        }
    }
}

struct WeatherStatsScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(.accent2)
                .edgesIgnoringSafeArea(.all)
            WeatherStatsScrollView(viewModel: WeatherViewModel(lat: "37.8045", lon: "-122.2714"))
        }
    }
}
