//
//  SwiftUIView.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI

struct BikesView: View {
    @StateObject var viewModel: ExploreViewModel
    
    init(viewModel: ExploreViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Bikes Available")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                ForEach(viewModel.VehicleCars) { vehicleCar in
                    let index = viewModel.VehicleCars.firstIndex(where: { $0.id == vehicleCar.id }) ?? 0
                    
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
    }
}

#Preview {
    BikesView(viewModel: ExploreViewModel())
}
