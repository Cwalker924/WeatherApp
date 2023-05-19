//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/18/23.
//

import SwiftUI

struct LoadingView: View {
    var color: Color = Color(.background)
    
    var body: some View {
        ProgressView()
            .scaleEffect(1.5)
            .tint(color)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
