//
//  CustomSearchBar.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI

struct CustomSearchBar: View {
    @State private var isEditing = false
    @State private var searchText = ""
    var selectedCity: String = ""
    var indianCities = [ "Chennai","Bangalore","Hyderabad","Pune","Delhi","Mumbai", "Lucknow"]
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.leading, 8)
                            .foregroundColor(.gray)
                        
                        if isEditing {
                            TextField("Search a vehicle...", text: $searchText)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        } else {
                            Text("Search a vehicle...")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
//                        if isEditing {
//                            Button(action: {
//                                withAnimation {
//                                    isEditing = false
//                                }
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                                    .padding(.trailing, 8)
//                                    .foregroundColor(.gray)
//                            }
//                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                }
//                .onTapGesture {
//                    withAnimation {
//                        isEditing.toggle()
//                    }
//                }
                
            }
            .overlay {
                NavigationLink(destination: SearchView()){Capsule()
                        .stroke(lineWidth: 0.5)
                        .foregroundColor(Color(.systemGray4))
                    .shadow(color: .black.opacity(0.4), radius: 10)}
            }
            .padding(.horizontal)
            SearchCityView(cities: indianCities)
        }
    }
    
    
    struct CustomSearchBar_Previews: PreviewProvider {
        static var previews: some View {
            CustomSearchBar()
        }
    }
    struct SearchCityView: View {
        var cities: [String]
        @StateObject private var citySelectionManager: CitySelectionManager = CitySelectionManager()

        var body: some View {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(cities, id: \.self) { city in
                            CityBox(city: city, citySelectionManager: citySelectionManager)
                        }
                    }
                    .padding()
                }
            }
        }
    }

    struct CityBox: View {
        var city: String
        @ObservedObject var citySelectionManager: CitySelectionManager

        var body: some View {
            Button(action: {
                // Handle button tap action for the city
                if citySelectionManager.selectedCity == city {
                    citySelectionManager.selectedCity = nil
                } else {
                    citySelectionManager.selectedCity = city
                }
            }) {
                Text(city)
                    .font(.subheadline)
                    .padding()
                    .foregroundColor(Color.white.opacity(1))
                    .background(citySelectionManager.selectedCity == city ? Color.white.opacity(0.5) : Color.white.opacity(0.2))
                    .cornerRadius(10)
            }
        }
    }
    class CitySelectionManager: ObservableObject {
        @Published var selectedCity: String?

        init(selectedCity: String? = nil) {
            self.selectedCity = selectedCity
        }
    }
}

