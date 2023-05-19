//
//  SearchBarView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import SwiftUI

typealias TapAction = () -> ()

struct SearchBarView: View {
    @Binding var text: String
    @Binding var hideShadow: Bool
    let deleteTapAction: TapAction
    
    var body: some View {
        HStack{
            TextField(Constants.Search.searchBarHelperText, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
            deleteButtonView
        }
        .font(.system(size: 15, weight: .light))
        .padding(.vertical, 10)
        .padding(.leading, 20)
        .padding(.trailing, 10)
        .background(Color(.background))
        .cornerRadius(10)
        .shadow(color: Color(hideShadow ? .clear : .primaryColor), radius: 5, x: 2, y: 4)
        .shadow(color: Color(hideShadow ? .clear : .primaryColor), radius: 1, x: 1, y: 1)
        .shadow(color: hideShadow ? .clear : .white, radius: 4, x: -2, y: -4)
        .shadow(color: hideShadow ? Color(.black) : .clear, radius: 5, x: 0, y: 0)
        .animation(.easeInOut(duration: 0.2), value: hideShadow)
        
    }
    
    var deleteButtonView: some View {
        Button {
            deleteTapAction()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .fontWeight(.bold)
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.background)
            SearchBarView(text: .constant(""), hideShadow: .constant(false), deleteTapAction: {})
        }
    }
}
