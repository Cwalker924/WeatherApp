//
//  LocationButtonView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/18/23.
//

import SwiftUI

struct LocationButtonView: View {
    
    @Binding var hideShadow: Bool
    var locationTapAction: TapAction
    
    var body: some View {
        Button {
            locationTapAction()
        } label: {
            Image(systemName: "location.fill")
                .foregroundColor(.gray)
                .font(.system(size: 15, weight: .light))
                .padding(10)
                .background(Color(.background))
                .cornerRadius(10)
                .shadow(color: Color(hideShadow ? .clear : .primaryColor), radius: 5, x: 2, y: 4)
                .shadow(color: Color(hideShadow ? .clear : .primaryColor), radius: 1, x: 1, y: 1)
                .shadow(color: hideShadow ? .clear : .white, radius: 4, x: -2, y: -4)
                .animation(.easeInOut(duration: 0.2), value: hideShadow)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct LocationButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LocationButtonView(hideShadow: .constant(false), locationTapAction: {})
    }
}
