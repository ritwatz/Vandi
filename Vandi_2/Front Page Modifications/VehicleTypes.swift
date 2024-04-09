//
//  VehicleTypes.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI
struct VehicleTypes: View {
    @StateObject var viewModel: ExploreViewModel
    @State private var selectedBrand: Brand?

    init(viewModel: ExploreViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
            NavigationStack {
                VStack {
                    HStack {
                        Text("Select the Ride :")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    .padding()
                        HStack {
                            NavigationLink(destination: CarsListView(viewModel: ExploreViewModel())) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                    .frame(width: 110, height: 110)
                                    .shadow(radius: 1)
                                    .overlay {
                                        VStack {
                                            Image("car2")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                            Text("Cars")
                                                .foregroundColor(.primary)
                                                .font(.body)
                                        }
                                    }
                            }
                            
                            NavigationLink(destination: BikesListView(viewModel: ExploreViewModel())) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                    .frame(width: 110, height: 110)
                                    .shadow(radius: 1)
                                    .overlay {
                                        VStack {
                                            Image("bike")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                            Text("Bikes")
                                                .foregroundColor(.primary)
                                                .font(.body)
                                        }
                                    }
                            }
                            
                            NavigationLink(destination: ScootysListView(viewModel: ExploreViewModel())) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                    .frame(width: 110, height: 110)
                                    .shadow(radius: 1)
                                    .overlay {
                                        VStack {
                                            Image("thumb.cms")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                            Text("Scootys")
                                                .foregroundColor(.primary)
                                                .font(.body)
                                        }
                                    }
                            }
                        }
                        .navigationTitle("Vehicle Types")
                }
            }
        }
    }



#Preview {
    VehicleTypes(viewModel: ExploreViewModel())
}


