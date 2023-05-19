//
//  AnimatedBackgroundView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/19/23.
//

import SwiftUI

struct AnimatedBackgroundView: View {
    @State private var animateBG: Bool = false
    
    var body: some View {
        LinearGradient(colors: [Color(.accent1).opacity(animateBG ? 0.4 : 0), Color(.accent2)], startPoint: animateBG ? .topLeading: .topTrailing, endPoint: animateBG ? .bottomTrailing: .bottomLeading)
            .onAppear {
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                    self.animateBG = true
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color(.background))
                    .shadow(color: Color.primary.opacity(0.5), radius: 8)
            )
    }
}

struct AnimatedBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackgroundView()
    }
}
