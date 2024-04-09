//
//  allCarCard.swift
//  Vandi_2
//
//  Created by admin49 on 30/03/24.
//

import SwiftUI

struct allCarCard: View {
    @ObservedObject var vehicleViewModel = VehicleDataViewModel()
    
    var body: some View {
        VStack {
            ForEach(vehicleViewModel.vehicleData.filter{$0.vehicleType == "car"} ) { detail in
                VStack(alignment: .leading) {
           //         NavigationLink(destination : filename()){
                        vehicleCarCardView(vehicleName: detail.vehicleName, description: detail.description, vendorId: detail.vendorId, imageURL: detail.imageURL)
           //         }
                    
                }
                .padding()
            }
        }
        .onAppear() {
            vehicleViewModel.fetchVehicleDetails()
        }
    }
}

#Preview {
    allCarCard()
}
