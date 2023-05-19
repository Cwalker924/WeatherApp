//
//  NoResultCell.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/17/23.
//

import SwiftUI

struct NoResultCell: View {
    var body: some View {
        Text(Constants.Search.noResult)
            .foregroundColor(Color.black)
            .font(.system(size: 17, weight: .light))
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.background))
            .cornerRadius(8)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
}

struct NoResultCell_Previews: PreviewProvider {
    static var previews: some View {
        NoResultCell()
    }
}
