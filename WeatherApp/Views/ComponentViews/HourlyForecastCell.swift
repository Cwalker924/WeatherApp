//
//  HourlyForecastCell.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/19/23.
//

import SwiftUI

struct HourlyForecastCell: View {
    let time: String
    let systemImage: String
    let temp: String
    
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .overlay {
                contentView
            }
            .frame(width: 120, height: 180)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 3)
    }
    
    var contentView: some View {
        VStack(spacing: 20) {
            Text(time)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: systemImage)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .yellow)
                .font(.system(size: 40))
                .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
            
            Text(temp)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

struct HourlyForecastCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.accent2)
                .edgesIgnoringSafeArea(.all)
            HourlyForecastCell(time: "2PM", systemImage: "cloud.sun.fill", temp: "35")
        }
    }
}
