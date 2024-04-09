//
//  BikeListCard.swift
//  Vandi_2
//
//  Created by user2 on 04/03/24.
//

import SwiftUI

struct BikeCardView: View {
    var bike: VehicleCar
    var viewModel: ExploreViewModel
    var body: some View {
        VStack(alignment: .leading) {
            // Bike Photo
            VStack {
                TabView {
                    ForEach(bike.imagesNames, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: .infinity, height: 300)
                    }
                }
                .frame(width: .infinity, height: 300)
                .tabViewStyle(.page)
                .cornerRadius(10)
            }
            .overlay {
                VStack(alignment: .center, spacing: 30) {
                    HStack(alignment: .center) {
                        Text(bike.carName)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(width: .infinity)
                    .offset(y: -5)

                    // Bike Specifications
                    HStack(spacing: 80) {
                        HStack {
                            Label("\(bike.transmissionType)", systemImage: "car")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .offset(x: -15)

                        HStack {
                            Label("\(String(format: "%.1f",bike.milage)) Km/L", systemImage: "speedometer")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .offset(x: 20)
                    }
                    .offset(x: -5, y: -25)
                }
                .offset(y: 120)
            }
            .overlay {
                Label("Rating: \(String(format: "%.1f", bike.rating))", systemImage: "star.fill")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .offset(x: 100, y: -130)
            }
            
            HStack(spacing: 60) {
                Label("\(String(format: "%.0f", bike.distanceAway)) km away", systemImage: "person.fill")
                    .offset(x: 5)
                    .font(.headline)
                    .offset(x: -10)

                HStack {
                    Text("\(String(format: "%.0f", bike.pricePerHour))/Hour")
                        .font(.subheadline)
                        .font(.headline)
                        .bold()
                    Label("", systemImage: "circle.fill")
                        .font(.caption2)
                        .offset(x: 3, y: -2)
                        .foregroundColor(.mint)
                    Text("\(String(format: "%.0f", bike.pricePerDay))/Day")
                        .font(.subheadline)
                        .font(.headline)
                        .bold()
                }
            }
            
            .offset(x: 10, y: 4)
        }
        .frame(width: .infinity, height: 340, alignment: .top)
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct BikesListView: View {
    @ObservedObject var viewModel: ExploreViewModel
    @State private var searchText = ""
    @State private var sortPerDayEnabled = false
    @State private var sortPerDayAscending = true
    @State private var sortPerHourEnabled = false
    @State private var sortPerHourAscending = true
    //    @State private var showAutomaticTransmission = false
    //    @State private var showManualTransmission = false
    @State private var isFilterDropdownVisible = false
    @State private var minPricePerHour: Double = 0
    @State private var maxPricePerHour: Double = 1000 {
        didSet {
            if maxPricePerHour < minPricePerHour {
                minPricePerHour = maxPricePerHour
            }
        }
    }
    @State private var minPricePerDay: Double = 0
    @State private var maxPricePerDay: Double = 10000 {
        didSet {
            if maxPricePerDay < minPricePerDay {
                minPricePerDay = maxPricePerDay
            }
        }
    }
    @State private var minPriceDiasble: Double = 0
    @State private var maxPriceDisable: Double = 100
    
     var filteredBikes: [VehicleCar] {
        var filtered = viewModel.VehicleBikes
        
        filtered.sort { $0.distanceAway < $1.distanceAway }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { bike in
                let searchString = searchText.lowercased()
                return bike.carName.lowercased().contains(searchString) ||
                "\(bike.pricePerHour)".contains(searchString) ||
                "\(bike.pricePerDay)".contains(searchString) ||
                "\(bike.distanceAway)".contains(searchString)
            }
        }
        
        if sortPerDayEnabled {
            filtered.sort { bike1, bike2 in
                if sortPerDayAscending {
                    return bike1.pricePerDay < bike2.pricePerDay
                } else {
                    return bike1.pricePerDay > bike2.pricePerDay
                }
            }
        } else if sortPerHourEnabled {
            filtered.sort { bike1, bike2 in
                if sortPerHourAscending {
                    return bike1.pricePerHour < bike2.pricePerHour
                } else {
                    return bike1.pricePerHour > bike2.pricePerHour
                }
            }
        }
        
        //        if showAutomaticTransmission {
        //            filtered = filtered.filter { $0.transmissionType == "Automatic" }
        //        }
        //
        //        if showManualTransmission {
        //            filtered = filtered.filter { $0.transmissionType == "Manual" }
        //        }
        
        // Filter by price range
        filtered = filtered.filter { bike in
            let price = sortPerDayEnabled ? bike.pricePerDay : bike.pricePerHour
            if sortPerDayEnabled || sortPerHourEnabled {
                return price >= Int((sortPerDayEnabled ? minPricePerDay : minPricePerHour)) &&
                price <= Int((sortPerDayEnabled ? maxPricePerDay : maxPricePerHour))
            } else {
                return true
            }
        }
        
        return filtered
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 8)
                        .padding([.top, .bottom], 4)
                    
                    Button(action: {
                        self.isFilterDropdownVisible.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .foregroundColor(.blue)
                            .padding(8)
                    }
                    .popover(isPresented: $isFilterDropdownVisible, arrowEdge: .top) {
                        filterDropdownMenu().presentationDetents([.fraction(0.3),.fraction(0.4)])
                            .padding()
                    }
                }
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(filteredBikes) { bike in
                            BikeCardView(bike: bike, viewModel: ExploreViewModel())
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Bikes")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func filterDropdownMenu() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle(isOn: $sortPerDayEnabled, label: {
                Text("Price Per Day")
            })
            .padding(.trailing, 20)
            .onChange(of: sortPerDayEnabled) { value in
                if value {
                    sortPerHourEnabled = false
                }
            }
            
            if sortPerDayEnabled {
                HStack {
                    Toggle(isOn: $sortPerDayAscending, label: {
                        Text("Low to High")
                    })
                    Toggle(isOn: Binding<Bool>(
                        get: { !self.sortPerDayAscending },
                        set: { newValue in
                            sortPerDayAscending = !newValue
                            sortPerHourAscending = newValue
                        }
                    ), label: {
                        Text("High to Low")
                    })
                }
            }
            
            Toggle(isOn: $sortPerHourEnabled, label: {
                Text("Price Per Hour")
            })
            .padding(.trailing, 20)
            .onChange(of: sortPerHourEnabled) { value in
                if value {
                    sortPerDayEnabled = false
                }
            }
            
            if sortPerHourEnabled {
                HStack {
                    Toggle(isOn: $sortPerHourAscending, label: {
                        Text("Low to High")
                    })
                    Toggle(isOn: Binding<Bool>(
                        get: { !self.sortPerHourAscending },
                        set: { newValue in
                            sortPerHourAscending = !newValue
                            sortPerDayAscending = newValue
                        }
                    ), label: {
                        Text("High to Low")
                    })
                }
            }
            
            //        Toggle(isOn: $showAutomaticTransmission, label: {
            //            Text("Automatic")
            //        })
            //        Toggle(isOn: $showManualTransmission, label: {
            //            Text("Manual")
            //        })
            
            if sortPerDayEnabled {
                HStack {
                    Text("Min Price: \(Int(minPricePerDay))")
                    Slider(value: $minPricePerDay, in: 0...10_000, step: 100)
                }
                HStack {
                    Text("Max Price: \(Int(maxPricePerDay))")
                    if minPricePerDay < maxPricePerDay {
                        Slider(value: $maxPricePerDay, in: minPricePerDay...10_000, step: 100)
                    } else {
                        Slider(value: $maxPricePerDay, in: 0...10_000, step: 100)
                            .disabled(true)
                    }
                }
            } else if sortPerHourEnabled {
                HStack {
                    Text("Min Price: \(Int(minPricePerHour))")
                    Slider(value: $minPricePerHour, in: 0...1_000, step: 10)
                }
                HStack {
                    Text("Max Price: \(Int(maxPricePerHour))")
                    if minPricePerHour < maxPricePerHour {
                        Slider(value: $maxPricePerHour, in: minPricePerHour...1_000, step: 10)
                    } else {
                        Slider(value: $maxPricePerHour, in: 0...1_000, step: 10)
                            .disabled(true)
                    }
                }
            } else {
                // Sliders for when both price per day and price per hour are disabled
                HStack {
                    Text("Min Price: \(Int(minPriceDiasble))")
                    Slider(value: $minPricePerHour, in: 0...100, step: 10)
                }
                HStack {
                    Text("Max Price: \(Int(maxPriceDisable))")
                    if minPricePerHour < maxPriceDisable {
                        Slider(value: $maxPriceDisable, in: minPriceDiasble...100, step: 10)
                    } else {
                        Slider(value: $maxPriceDisable, in: 0...100, step: 10)
                            .disabled(true)
                    }
                }
            }
            
            //        Button(action: {
            //            // Reset all filters
            //            resetFilters()
            //        }, label: {
            //            Text("Reset All Filters").foregroundColor(.white)
            //            Image(systemName: "multiply.circle.fill").foregroundColor(.white)
            //        }).padding().background(Rectangle().fill(Color.blue).cornerRadius(10.0)).offset(x:95,y:50)
        }
    }
}
    
    
    struct ContentView_Previews5: PreviewProvider {
        static var previews: some View {
            BikesListView(viewModel: ExploreViewModel())
        }
    }
