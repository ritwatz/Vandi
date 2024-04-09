//
//  BikeListView.swift
//  Vandi_2
//
//  Created by user2 on 04/03/24.
//

import SwiftUI

struct BikeListView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    //StatusBar()
                    SearchBarListView()
                    BikesListView(viewModel: ExploreViewModel())
                }
                
            }.background(Color.black.opacity(0.1))
        }
    }
}

#Preview {
    BikeListView()
}
