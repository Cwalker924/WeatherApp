//
//  WeatherStatsDetailCell.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/19/23.
//

import SwiftUI

struct WeatherStatsDetailCell: View {
    let systemImage: String
    let value: String
    
    var body: some View {
        Circle()
            .fill(Color.clear)
            .overlay {
                VStack(spacing: 5) {
                    Image(systemName: systemImage)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .yellow)
                        .font(.system(size: 25, weight: .light))
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                    
                    if value.isEmpty {
                        RoundedRectangle(cornerRadius: 1)
                            .frame(width: 20, height: 2)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                    } else {
                        Text(value)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .light))
                    }
                }
            }
            .frame(width: 100, height: 100)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 3)
    }
}

struct WeatherStatsDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.accent2)
                .edgesIgnoringSafeArea(.all)
            WeatherStatsDetailCell(systemImage: "sunrise.fill", value: "7AM")            
        }
    }
}
