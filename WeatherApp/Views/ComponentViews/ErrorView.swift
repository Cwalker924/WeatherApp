//
//  ErrorView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/18/23.
//

import SwiftUI

struct ErrorView: View {
    let title: String
    let error: Error
    let reloadTapAction: TapAction

    var body: some View {
        VStack(spacing: 13) {
            HStack(alignment: .top) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(.gray))
                Spacer()
                reloadButton
            }
            .frame(alignment: .center)
            
            RoundedRectangle(cornerRadius: 0.5)
                .fill(Color(.primaryColor))
                .frame(height: 1)
                .padding(.horizontal, 20)
            
            // We would usually want to display something human
            // readable here instead of the error itself.
            Text(error.localizedDescription)
                .font(.system(size: 13))
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(.gray))
                .multilineTextAlignment(.center)

        }
        .padding()
        .background(Color(.background))
        .cornerRadius(10)
        .font(.system(size: 18))
        .foregroundColor(Color(.black))
        .shadow(color: .black.opacity(0.3), radius: 5, x:5, y:5)
        .padding(.horizontal)
    }
    
    var reloadButton: some View {
        Button {
            reloadTapAction()
        } label: {
            Image(systemName: "arrow.clockwise")
                .font(.system(size: 18))
                .foregroundColor(Color(.black))
        }
        .buttonStyle(PlainButtonStyle())

    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: Constants.Weather.errorTitle, error: URLError(.badServerResponse), reloadTapAction: {})
    }
}
