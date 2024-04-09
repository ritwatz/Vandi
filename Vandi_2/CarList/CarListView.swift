//
//  ContentView.swift
//  Vandi_2
//
//  Created by user2 on 02/02/24.
//

import SwiftUI

struct CarListView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    //StatusBar()
                    
                    CarsListView(viewModel: ExploreViewModel())
                }
                
            }.background(Color.black.opacity(0.1))
        }
    }
}

#Preview {
    CarListView()
}
