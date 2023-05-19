//
//  HourlyForecastScrollView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/19/23.
//

import SwiftUI

struct HourlyForecastScrollView: View {
    let viewModel: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            titleView
            dividerView
            scrollView
        }
    }
    
    var titleView: some View {
        Text(Constants.Weather.forecastByTheHrTitle)
            .font(.system(size: 15, weight: .light))
            .foregroundColor(.white)
            .padding(.horizontal)
    }
    
    var dividerView: some View {
        Divider()
            .frame(height: 0.5)
            .overlay(Color(.white))
            .padding(.horizontal)
    }
    
    var scrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(viewModel.dummyHrs, id: \.self) { hr in
                    let randomIcon = viewModel.dummyIcons.randomElement()!
                    let randomTemp = viewModel.dummyTemp.randomElement()!
                    HourlyForecastCell(time: hr, systemImage: randomIcon, temp: randomTemp)
                }
            }
            .padding()
        }
    }
}

struct HourlyForecastScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.accent2)
                .edgesIgnoringSafeArea(.all)
            HourlyForecastScrollView(viewModel: WeatherViewModel(lat: "37.8045", lon: "-122.2714"))
        }
    }
}
