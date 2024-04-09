//
//  DetailBikeView.swift
//  Vandi_2
//
//  Created by user2 on 29/02/24.
//

import SwiftUI

struct DetailBikeView: View {
    let index: Int
    @StateObject private var viewModel: ExploreViewModel
    
    init(viewModel: ExploreViewModel,index: Int) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.index = index
    }
    var body: some View {
        
        //NavigationView {
            ScrollView {
                VStack(alignment: .leading,spacing: 15) {
                    BikeImageViewPager(viewModel: viewModel, index: index)
                    VStack(alignment: .leading,spacing: 15) {
                        Text(viewModel.VehicleBikes[index].carName)
                            .font(.headline)
                            .fontWeight(.bold)
                        HStack(spacing: 2) {
                            Text(String(format: "%.1f", viewModel.VehicleBikes[index].rating))
                            
                            Image(systemName: "star.fill")
                                .foregroundStyle(.orange)
                        }
                    }
                    .padding(.horizontal)
                    Divider()
                    TripDateView()
                    Divider()
                    LocationView(title: "Pickup & Return", message: "SRM University")
                    Divider()
                    CancellationView(title: "Cancellation policy", message: "Free cancellation")
                    Divider()
                    BikeInfoView(title: "Distance included", message: viewModel.VehicleBikes[index].maxDistance == nil ? "Unlimited" : "\(viewModel.VehicleBikes[index].maxDistance ?? 0) km")
                    //Divider()
    //                InsuranceInfoView(title: "Insurance & Protection", message: viewModel.cars[index].insurance)
                    Divider()
                    BikeBasicsView(title: "Car Basics", numberOfSeats: viewModel.VehicleBikes[index].numberOfSeats, numberOfDoors: viewModel.VehicleBikes[index].numberOfDoors, gasType: viewModel.VehicleBikes[index].GasType)
                    Divider()
                    BikeInfoView(title: "Description", message: viewModel.VehicleBikes[index].description)
                    Divider()
                    HostView(title: "Hosted by", message:  viewModel.VehicleBikes[index].hostName, imageName: viewModel.VehicleBikes[index].hostImageName, joinDate:viewModel.VehicleBikes[index].hostJoinDate)
                    Spacer()
                        .frame(height: 120)
                    
                }
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea()
            .background(Color(.systemGray6))
            .toolbar(.hidden, for: .tabBar)
            .overlay {
                VStack {
                    Spacer()
                    ZStack {
                        Color.white
                            .frame(width: UIScreen.main.bounds.width, height: 120)
                        HStack {
                            VStack {
                                Text("₹ \(viewModel.VehicleBikes[index].pricePerDay) per day")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                Text("₹ \(viewModel.VehicleBikes[index].pricePerDay * 3) est. total")
                                    .font(.subheadline)
                                    .underline()
                            }
                            Spacer()
    //                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
    //                            Text("Continue")
    //                                .foregroundStyle(.white)
    //                                .frame(width: 120, height: 35)
    //                                .background(.blue)
    //                                .clipShape(RoundedRectangle(cornerRadius: 8))
    //                        })
                            NavigationLink(destination: PaymentScreen()/*.navigationBarBackButtonHidden()*/
                            ) {
                                Text("Continue")
                                    .foregroundColor(.white) // Changed from foregroundStyle to foregroundColor
                                    .frame(width: 120, height: 35)
                                    .background(Color.blue) // Changed from .blue to Color.blue
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                            }
                            
                        }
                        .padding(.horizontal,20)
                        .padding(.vertical)
                    }
                    
                }
                .ignoresSafeArea()
        }
        }
    }
//}

#Preview {
    DetailBikeView(viewModel: ExploreViewModel(), index: 0)
}

struct BikeInfoView: View {
    var title: String
    var message: String
    var body: some View {
        VStack(alignment: .leading,spacing: 15) {
            Text(title)
                .foregroundStyle(Color(.darkGray))
                .font(.headline)
                .fontWeight(.semibold)
            Text(message)
        }
        .padding(.horizontal)
    }
}

struct BikeBasicsView: View {
    var title: String
    var numberOfSeats: Int
    var numberOfDoors: Int
    var gasType: String
    var body: some View {
        VStack(alignment: .leading,spacing: 15) {
            Text(title)
                .foregroundStyle(Color(.darkGray))
                .font(.headline)
                .fontWeight(.semibold)
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    VStack {
                        Image(systemName: "carseat.left.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("\(numberOfSeats) seats")
                    }
                    VStack {
                        Image(systemName: "car.window.right")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("\(numberOfDoors) doors")
                    }
                    VStack {
                        Image(systemName: "fuelpump")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text(gasType)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
        }
        .padding(.horizontal)
    }
}
