//
//  LocationCell.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/16/23.
//

import SwiftUI

struct LocationCell: View {
    var viewModel: LocationCellViewModel
    var isSelected: Bool = false
    @State var opacity: Double = 0
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            flagView
            VStack {
                locationView
                    .frame(maxWidth: .infinity, alignment: .leading)
                coordinatorView
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(backgroundView)
        .cornerRadius(8)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
    
    @ViewBuilder
    var backgroundView: some View {
        if isSelected {
            LinearGradient(colors: [Color(.accent1), Color(.accent2)], startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            Color(.background)
        }
    }
    
    @ViewBuilder
    var flagView: some View {
        if let flag = viewModel.flag {
            Text(flag)
                .font(.system(size: 35))
                .shadow(color: .black.opacity(0.3), radius: 4, x: 3, y: 3)
        }
    }
    
    var locationView: some View {
        HStack(alignment: .bottom) {
            Text(viewModel.city)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(isSelected ? Color(.white) : Color(.gray))
            Text(viewModel.state ?? "")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(isSelected ? Color(.white) : Color(.primaryColor))
        }
        .lineLimit(1)
    }
    
    var coordinatorView: some View {
        Text(viewModel.coord)
            .font(.system(size: 11, weight: .medium))
            .foregroundColor(isSelected ? Color(.white) : Color(.primaryColor))
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                LocationCell(viewModel: LocationCellViewModel(location: .testLocation))
                LocationCell(viewModel: LocationCellViewModel(location: .testLocation), isSelected: true)
            }
            .padding()
            .background(Color(.background))
            VStack {
                LocationCell(viewModel: LocationCellViewModel(location: .testLocation))
                LocationCell(viewModel: LocationCellViewModel(location: .testLocation), isSelected: true)
            }
            .padding()
            .background(Color.black.opacity(0.5))
            .background(.ultraThinMaterial)
        }
    
    }
}

extension Location {
    // For testing and preview purposes ONLY
    fileprivate static let testLocation = Location(name: "San Leandro", lat: "37.7205", lon: "-122.1587", country: "US", state: "California", zip: nil)
}
