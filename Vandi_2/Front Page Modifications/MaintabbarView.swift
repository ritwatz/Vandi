//
//  MaintabbarView.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI

struct MainTabbarView: View {
    @State private var selectedTab: Int = 0
    @StateObject private var viewModel = ExploreViewModel()
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                
                ExploreView(viewModel: viewModel, citySelectionManager: CitySelectionManager())
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                                .symbolVariant(selectedTab == 0 ? .fill : .none)
                            Text("Home")
                        }
                    }
                    .tag(0)
                
                HistoryView()
                    .tabItem {
                        VStack {
                            Image(systemName: "road.lanes")
                                .symbolVariant(selectedTab == 1 ? .fill : .none)
                            Text("Trips")
                        }
                    }
                    .tag(1)
                
                // Uncomment this once implemented
                // FavoritesView()
                //     .tabItem {
                //         VStack {
                //             Image(systemName: "heart")
                //                 .symbolVariant(selectedTab == 2 ? .fill : .none)
                //             Text("Favorites")
                //         }
                //     }
                //     .tag(2)
                
                // Uncomment this once implemented
                // PaymentScreen()
                //     .tabItem {
                //         VStack {
                //             Image(systemName: "clock")
                //                 .symbolVariant(selectedTab == 3 ? .fill : .none)
                //             Text("History")
                //         }
                //     }
                //     .tag(3)
                
                ProfilePage()
                    .tabItem {
                        VStack {
                            Image(systemName: "person")
                                .symbolVariant(selectedTab == 2 ? .fill : .none)
                            Text("Profile")
                        }
                    }
                    .tag(4)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

struct MainTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
    }
}

