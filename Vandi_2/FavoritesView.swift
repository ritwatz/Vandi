//
//  FavoritesView.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel: ExploreViewModel
    var favoriteCars: [VehicleCar]
    init(viewModel: ExploreViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        favoriteCars = viewModel.VehicleCars.filter({ $0.isFavorite == true })
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(favoriteCars) { car in
                        let index = viewModel.VehicleCars.firstIndex(where: {$0 == car}) ?? 0
                        NavigationLink {
                            DetailCarView(viewModel: viewModel, index: index)
                                .navigationBarBackButtonHidden()
                        } label: {
                            CustomCarView(index: index, viewModel: viewModel)
                        }
                        
                        
                    }
                }
                .padding()
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    FavoritesView(viewModel: ExploreViewModel())
}
