//
//  BikeView.swift
//  Vandi_2
//
//  Created by user2 on 29/02/24.
//

import SwiftUI

import SwiftUI

struct BikeView: View {
    @StateObject var viewModel: ExploreViewModel
    
    init(viewModel: ExploreViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(viewModel.VehicleCars) { vehicleCar in
                        if vehicleCar.vehicleType == "Bike" {
                            let index = viewModel.VehicleCars.firstIndex(where: { $0.id == vehicleCar.id }) ?? 0
                            
                            NavigationLink {
                                DetailCarView(viewModel: viewModel, index: index)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                CustomCarView(index: index, viewModel: viewModel)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Bikes")
        }
    }
}

struct BikeView_Previews: PreviewProvider {
    static var previews: some View {
        BikeView(viewModel: ExploreViewModel())
    }
}

