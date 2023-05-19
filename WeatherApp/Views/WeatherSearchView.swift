//
//  WeatherSearchView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/15/23.
//

import SwiftUI

struct WeatherSearchView: View {
    @StateObject var viewModel: WeatherSearchViewModel

    @State var searchViewsOpacity = 0.0
    @State var mainContentViewsOpacity = 0.0
    
    var body: some View {
        ZStack {
            Color(.background)
                .edgesIgnoringSafeArea(.vertical)
            mainContentView
            searchFocusBackground
        }
        .frame(maxHeight: .infinity)
        .overlay { searchViews }
        .onAppear {
            viewModel.getUsersSavedLocations()
            withAnimation(Animation.easeIn(duration: 0.7).delay(0.2)) {
                searchViewsOpacity = 1
            }
            withAnimation(Animation.easeOut(duration: 0.7).delay(0.5)) {
                mainContentViewsOpacity = 1
            }
        }
        .navigationTitle(Constants.Search.weatherSearchViewTitle)
    }
    
    @ViewBuilder
    var mainContentView: some View {
        switch viewModel.state {
        case .cells(let searchCellViewModels): configureUserLocationsView(searchCellViewModels)
                .opacity(mainContentViewsOpacity)
        case .empty: emptyStateView.opacity(mainContentViewsOpacity)
        case .noAPIKey:  noAPIKeyView
        }
    }
    
    /// The background that get toggled when search in process
    @ViewBuilder
    var searchFocusBackground: some View {
        Color(viewModel.showSearchResult ? .black : .clear)
            .background(.ultraThinMaterial)
            .edgesIgnoringSafeArea(.vertical)
            .opacity(viewModel.showSearchResult ? 0.7 : 0)
            .onTapGesture {
                viewModel.showSearchResult = false
                viewModel.locationQuery = ""
            }
            .animation(.easeInOut(duration: 0.2), value: viewModel.showSearchResult)
    }
    
    var searchViews: some View {
        VStack {
            HStack {
                LocationButtonView(hideShadow: $viewModel.showSearchResult) {
                    viewModel.getLocation()
                }
                SearchBarView(text: $viewModel.locationQuery, hideShadow: $viewModel.showSearchResult, deleteTapAction: {
                    viewModel.locationQuery = ""
                })
                .onReceive(viewModel.$locationQuery.throttle(for: 0.3, scheduler: RunLoop.main, latest: true)) { search in
                    viewModel.getLocation(query: search)
                }
            }
            .padding(.top)
            .padding(.horizontal)
            searchResultView.opacity(viewModel.showSearchResult ? 1 : 0)
            Spacer()
        }
        .opacity(searchViewsOpacity)
    }
    
    var searchResultView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.searchCellViewModels) { cellVM in
                    let isSelected = viewModel.cellIsSelected(cellVM)
                    LocationCell(viewModel: cellVM, isSelected: isSelected)
                        .onTapGesture {
                            viewModel.showSearchResult = false
                            viewModel.locationQuery = ""
                            if !isSelected {
                                viewModel.usersLocations.insert(cellVM, at: 0)
                                viewModel.saveLocation(cellVM)
                            }
                            viewModel.navigateToWeatherView(cellVM)
                        }
                }
                
                if viewModel.showShowNoResultCell {
                    NoResultCell()
                }
            }
        }
        .background(Color.clear)
        .fixedSize(horizontal: false, vertical: true)
        .cornerRadius(8)
        .padding(.horizontal)
    }
    
    func configureUserLocationsView(_ cellViewModels: [LocationCellViewModel]) -> some View {
        List {
            Section(header:
                        Text(Constants.Search.recentSearches)
                .font(.system(size: 15, weight: .light))
                .foregroundColor(.gray)
            ) {
                ForEach(cellViewModels) { cellVM in
                    LocationCell(viewModel: cellVM, isSelected: true)
                        .shadow(color: Color(.accent2), radius: 5, x: 2, y: 4)
                        .shadow(color: Color.white, radius: 4, x: -2, y: -4)
                        .onTapGesture {
                            viewModel.navigateToWeatherView(cellVM)
                        }
                }
                .onDelete {
                    viewModel.remove(at: $0)
                }
            }
            .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .scrollIndicators(.hidden)
        .listStyle(PlainListStyle())
        .padding(.top, 50)
    }
    
    var emptyStateView: some View {
        ZStack{
            Color(.background)
            Text("No weather locations selected")
                .foregroundColor(.gray)
                .font(.system(size: 20))
        }
    }
    
    var noAPIKeyView: some View {
        let nsError = NSError(domain: Constants.Misc.noAPIKeyError, code: -1000)
        return ErrorView(title: Constants.Misc.noAPIKeyErrorTitle,error: nsError, reloadTapAction: {})
    }
}

struct WeatherSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSearchView(viewModel: WeatherSearchViewModel())
    }
}
