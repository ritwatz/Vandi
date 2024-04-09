//
//  ContentView.swift
//  Vandi_2
//
//  Created by user2 on 26/02/24.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            ZStack {
                //StatusBar()
                CarListView()
                MainTabbarView()
            }
        }
    }
}

#Preview {
    HomePage()
}
